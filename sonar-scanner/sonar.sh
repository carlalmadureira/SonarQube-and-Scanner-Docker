#!/bin/bash
echo
echo sonar-scanner • scan mode • debug
echo ==================================
echo

# -X debug mode

echo "sonar-scanner's output"
echo "======================"

    sonar-scanner \
        -Dsonar.host.url="$SONAR_HOST_URL" \
        -Dsonar.login="$USER_LOGIN" \
        -Dsonar.password="$USER_PASSWORD" \
        -Dsonar.projectKey="$SONAR_PROJECT_KEY" \
        -Dsonar.projectVersion="$SONAR_PROJECT_VERSION" \
        -Dsonar.sources="$SONAR_PROJECT_SOURCE" \
        -X
        ${@:2}
    2> >(tee -a /tmp/sonar-scanner-errors >&2)