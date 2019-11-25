#!/bin/bash
echo
echo kiwicom/sonar-scanner • preview mode
echo ====================================
echo This is a wrapper for \`$ sonar-scanner\` with default arguments to run in GitLab CI
echo It takes one argument: a comma-separated list of directories to check, such as: \`$ preview kw,test\`
echo If you want to customize it, add your extra arguments at the end.
echo The \`sonar-scanner\` binary is also available for fully customized usage.
echo

echo "sonar-scanner's output"
echo "======================"

NEW_COMMIT_SHAS=$(git log --pretty=format:%H ${CI_MERGE_REQUEST_TARGET_BRANCH:-master}..$CI_COMMIT_SHA | tr '\n' ',')

exec sonar-scanner \
        -Dsonar.host.url="$SONAR_HOST_URL" \
        -Dsonar.login="$USER_LOGIN" \
        -Dsonar.password="$USER_PASSWORD" \
        -Dsonar.projectKey="$SONAR_PROJECT_KEY" \
        -Dsonar.projectVersion="$SONAR_PROJECT_VERSION" \
        -Dsonar.sources="$1" \
        -X
    ${@:2}
