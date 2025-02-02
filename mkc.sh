#!/bin/bash

# Check if project name is given
if [ -z "$1" ]
then
  echo "Please provide a project name."
  exit 1
fi

# Project name
PROJECT_NAME=$1

# Function to create a C++ project
create_cpp_project() {
  mkdir -p "$PROJECT_NAME"/{src,include,build}

  cat <<EOL > "$PROJECT_NAME/src/main.cpp"
#include <iostream>

int main() {
    std::cout << "Hello, World!" << std::endl;
    return 0;
}
EOL

  cat <<EOL > "$PROJECT_NAME/CMakeLists.txt"
# Minimum CMake version required
cmake_minimum_required(VERSION 3.10)

# Project name
project($PROJECT_NAME)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Include directories
include_directories(include)

# Source files
file(GLOB_RECURSE SOURCES "src/*.cpp")

# Add executable
add_executable(\${PROJECT_NAME} \${SOURCES})
EOL

  echo "C++ project $PROJECT_NAME created successfully."
}

# Function to create a C project
create_c_project() {
  mkdir -p "$PROJECT_NAME"/{src,include,build}

  cat <<EOL > "$PROJECT_NAME/src/main.c"
#include <stdio.h>

int main() {
    printf("Hello, World!\\n");
    return 0;
}
EOL

  cat <<EOL > "$PROJECT_NAME/CMakeLists.txt"
# Minimum CMake version required
cmake_minimum_required(VERSION 3.10)

# Project name
project($PROJECT_NAME)

# Set C standard
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED True)

# Include directories
include_directories(include)

# Source files
file(GLOB_RECURSE SOURCES "src/*.c")

# Add executable
add_executable(\${PROJECT_NAME} \${SOURCES})
EOL

  echo "C project $PROJECT_NAME created successfully."
}

# Ask user for project type
read -p "Do you want to create a C or C++ project? (C/C++) " project_type

if [ "$project_type" == "C++" ] || [ "$project_type" == "c++" ]
then
  create_cpp_project
elif [ "$project_type" == "C" ] || [ "$project_type" == "c" ]
then
  create_c_project
else
  echo "Unknown project type. Please specify 'C' or 'C++'."
  exit 1
fi

