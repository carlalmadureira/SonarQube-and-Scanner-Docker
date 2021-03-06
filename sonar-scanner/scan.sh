#!/bin/bash
echo
echo sonar-scanner • scan mode • debbug
echo ==================================
echo

# comando com -X para debug

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
