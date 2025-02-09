#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: mkj <domain> <projectName>"
  exit 1
fi

GROUP_ID=$1
ARTIFACT_ID=$2

mvn io.quarkus:quarkus-maven-plugin:create \
  -DprojectGroupId=${GROUP_ID} \
  -DprojectArtifactId=${ARTIFACT_ID} \
  -DclassName="${GROUP_ID}.GreetingResource" \
  -Dpath="/greeting"

cd ${ARTIFACT_ID}

# Optional: Add any additional dependencies you need
# awk command to include Lombok dependency
awk '
/<\/dependencies>/ {
    print "    <dependency>";
    print "        <groupId>org.projectlombok</groupId>";
    print "        <artifactId>lombok</artifactId>";
    print "        <version>1.18.34</version>";
    print "        <scope>provided</scope>";
    print "    </dependency>";
}
{ print }
' pom.xml > pom.xml.tmp && mv pom.xml.tmp pom.xml

echo "Quarkus project ${ARTIFACT_ID} created successfully with groupId ${GROUP_ID}, Lombok included"

