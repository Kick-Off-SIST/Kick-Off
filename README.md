# Kick-Off : K리그 통합 정보 및 예매 웹 서비스 (Team Semi-Project)

## 1. 프로젝트 개요
'Kick-Off'는 K리그 축구 팬들을 위한 통합 웹 서비스입니다. K리그 경기 일정 및 실시간 뉴스 확인부터, 경기장 티켓 예매, 구단 굿즈 구매, 팬들 간의 소통을 위한 커뮤니티와 실시간 채팅 기능까지 축구 팬덤에 필요한 핵심 기능들을 하나의 플랫폼에서 제공합니다.

## 2. Tech Stack

* **Frontend**
  <p>
    <img src="https://img.shields.io/badge/HTML5-E34F26?style=flat-square&logo=html5&logoColor=white" style="vertical-align: middle;">
    <img src="https://img.shields.io/badge/CSS3-1572B6?style=flat-square&logo=css3&logoColor=white" style="vertical-align: middle;">
    <img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=flat-square&logo=javascript&logoColor=black" style="vertical-align: middle;">
    <img src="https://img.shields.io/badge/Vue.js-4FC08D?style=flat-square&logo=vuedotjs&logoColor=white" style="vertical-align: middle;">
    <img src="https://img.shields.io/badge/jQuery-0769AD?style=flat-square&logo=jquery&logoColor=white" style="vertical-align: middle;">
    <img src="https://img.shields.io/badge/AJAX-005C84?style=flat-square" style="vertical-align: middle;">
    <img src="https://img.shields.io/badge/Axios-5A29E4?style=flat-square&logo=axios&logoColor=white" style="vertical-align: middle;">
  </p>

* **Backend**
  <p>
    <img src="https://img.shields.io/badge/Java21-ED8B00?style=flat-square&logo=openjdk&logoColor=white" style="vertical-align: middle;">
    <img src="https://img.shields.io/badge/Servlet%2FJSP-007396?style=flat-square&logo=java&logoColor=white" style="vertical-align: middle;">
    <img src="https://img.shields.io/badge/MyBatis-000000?style=flat-square" style="vertical-align: middle;">
  </p>
  
* **Database**
  <p>
    <img src="https://img.shields.io/badge/Oracle21c-F80000?style=flat-square&logo=oracle&logoColor=white" style="vertical-align: middle;">
  </p>

* **Server & Tools**
  <p>
    <img src="https://img.shields.io/badge/Apache_Tomcat-F8DC75?style=flat-square&logo=apachetomcat&logoColor=black" style="vertical-align: middle;">
    <img src="https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white" style="vertical-align: middle;">
    <img src="https://img.shields.io/badge/Eclipse_IDE-2C2255?style=flat-square&logo=eclipseide&logoColor=white" style="vertical-align: middle;">
  </p>

## 3. 주요 기능 (Key Features)

* **티켓 예매 및 경기 정보**
  * K리그 실제 승점 산정 방식(승점 > 다득점 > 득실차)을 적용한 팀/선수 순위 정보 제공
  * 경기 일정 조회 및 경기장 좌석 기반의 실시간 티켓 예매 시스템
* **커뮤니티 및 실시간 소통**
  * 게시판 및 댓글 기능을 통한 유저 간 소통
  * WebSocket을 활용한 실시간 접속자 채팅 기능
  * Naver API와 스케줄러를 연동하여 1분 주기로 K리그 실시간 뉴스 브로드캐스팅
  * Youtube API를 연동하여 특정 키워드의 동영상 목록 출력
* **굿즈 스토어**
  * 팀별 굿즈 상품 조회 및 장바구니 기능
  * 상품 좋아요 및 찜하기 로직 연동
* **선수 및 팀 정보**
  * 선수 목록 및 상세정보 제공
  * 팀 목록 및 상세정보 제공
  * Kakao API를 연동하여 각 팀의 홈구장 위치 및 가까운 역에서 오는 길, 주변 맛집 정보 제공

## 4. 트러블슈팅 (Troubleshooting)

**1. K리그 순위 산정 로직 구현 (MyBatis)**
* **문제:** 단순 승점 정렬이 아닌, 승점 동률 시 다득점, 득실차 순으로 순위를 결정해야 하는 K리그 고유 룰 적용 필요.
* **해결:** MyBatis SQL 매퍼 내에서 `RANK()` 함수와 다중 정렬 조건(`ORDER BY 승점 DESC, 득점 DESC, 득실차 DESC`)을 활용하여 정확한 순위가 계산되도록 쿼리 최적화.

**2. 실시간 뉴스 API 호출 시 NullPointerException 방어**
* **문제:** 외부 API(Naver 뉴스) 호출 시 일일 한도 초과나 일시적 서버 오류로 인해 비정상적인 응답이 올 경우, JSON 파싱 단계에서 `NullPointerException`이 발생하여 서버 동작에 지장을 줌.
* **해결:** API 응답값의 `items` 키 존재 여부 및 JSON 배열의 null 체크 로직을 방어적으로 추가. 에러 발생 시 예외를 던지지 않고 빈 문자열을 반환하도록 처리하여 서버 안정성 확보 및 정확한 에러 로그 출력.

**3. WebSocket 스케줄러 스레드 누수 방지**
* **문제:** 웹 애플리케이션 재시작 시 기존 스케줄러 스레드가 정상 종료되지 않고 좀비 스레드로 남아 `IllegalStateException` 유발.
* **해결:** 스케줄러 내부에서 예외 발생 시 `scheduler.shutdown()`을 호출하는 Self-Shutdown 로직을 구현하여 스레드 누수 방지.

**4. 반응형 UI 레이아웃 깨짐 현상 해결**
* **문제:** 예매 배너 등에서 텍스트 길이가 길어지거나 화면 폭이 좁아질 때, Flexbox 내부의 버튼 레이아웃이 찌그러지는 현상 발생.
* **해결:** Flexbox 속성(`flex-shrink-0`, `text-nowrap`)을 활용하여 요소 간의 고정 너비를 보장하고 엠블럼 이미지 비율(`object-fit: contain`)이 유지되도록 최적화.