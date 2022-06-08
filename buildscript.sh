#!/bin/bash

## 변수 설정

txtrst='\033[1;37m' # White
txtred='\033[1;31m' # Red
txtylw='\033[1;33m' # Yellow
txtpur='\033[1;35m' # Purple
txtgrn='\033[1;32m' # Green
txtgra='\033[1;30m' # Gray

BRANCH=$1
PROFILE=$2

function pull() {
  echo -e ""
  echo -e ">> Pull Request 🏃♂️ "
  git pull origin "${BRANCH:-msmasd}"
}

function gradleBuild() {
  echo -e ""
  echo -e ">> Graldle build️ "
  ./gradlew clean build
}

function stopAlreadyRunProcess() {
  PID=$(pgrep -f ".jar$")
  if [ -n "$PID" ]; then
    echo -e ""
    echo -e ">> stop process ${PID}"
    sudo kill -2 "$PID"
  fi
}

function runApplication() {
  echo -e ""
  echo -e ">> run Application profile: ${PROFILE}"
  nohup java -jar -Dspring.profiles.active="${PROFILE:-prod}" ./build/libs/subway-0.0.1-SNAPSHOT.jar 1>application.log 2>&1 &
}

echo -e "${txtylw}=======================================${txtrst}"
echo -e "${txtgrn}  << 스크립트 🧐 >>${txtrst}"
echo -e "${txtylw}=======================================${txtrst}"

pull
gradleBuild
stopAlreadyRunProcess
runApplication
