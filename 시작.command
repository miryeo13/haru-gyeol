#!/bin/bash
# MOA 시작 버튼: 더블클릭하면 서버가 켜지고 브라우저가 열려요.
# 끄려면 이 창에서 Ctrl+C 를 누르거나 창을 닫으세요.

PORT=5001                        # 포트 번호를 바꾸고 싶으면 여기 숫자를 수정
cd "$(dirname "$0")" || exit 1   # 이 파일이 있는 폴더(index.html 위치)로 이동
export LANG=en_US.UTF-8          # 한글 폴더 이름이 깨지지 않게 설정

# 이미 켜져 있으면 브라우저만 열고 끝냅니다
if lsof -nP -iTCP:$PORT -sTCP:LISTEN >/dev/null 2>&1; then
  echo "이미 실행 중이에요. 브라우저를 엽니다."
  open "http://localhost:$PORT"
  exit 0
fi

echo "MOA를 시작합니다...  주소: http://localhost:$PORT"
echo "(끄려면 이 창에서 Ctrl+C)"
( sleep 1; open "http://localhost:$PORT" ) &
ruby -E UTF-8:UTF-8 -run -e httpd . -p $PORT
