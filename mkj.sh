#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: mkj <domain> <projectName>"
  exit 1
fi

GROUP_ID=$1
ARTIFACT_ID=$2

mvn archetype:generate \
  -DgroupId=${GROUP_ID} \
  -DartifactId=${ARTIFACT_ID} \
  -Dversion="1.0-SNAPSHOT" \
  -DinteractiveMode=false \
  -DarchetypeArtifactId=maven-archetype-quickstart \
  -DarchetypeVersion=1.4

cd ${ARTIFACT_ID}

awk '
/<\/dependencies>/ {
    print "    <dependency>";
    print "        <groupId>org.projectlombok</groupId>";
    print "        <artifactId>lombok</artifactId>";
    print "        <version>1.18.24</version>";
    print "        <scope>provided</scope>";
    print "    </dependency>";
}
{ print }
' pom.xml > pom.xml.tmp && mv pom.xml.tmp pom.xml

echo "Maven project ${ARTIFACT_ID} created successfully with groupId ${GROUP_ID}, Lombok included"

