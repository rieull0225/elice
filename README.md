# elice team mini project

엘리스코딩 미니프로젝트입니다.
11월 6일 저녁 11시경에 시작하여 11월 7일 오전 2시에 마감합니다.

## 구조 및 코딩방식

- Clean Architecture를 사용하여, Entitiy, Repository, Controller를 분리하였습니다.
- MVVM 패턴을 사용해 Model, View, ViewModel을 나누었습니다.
- 크게 세 가지 기능으로 나누어진다고 판단, 기능별로 코드를 완성하였습니다.
- UI, UX를 먼저 완성하고 그 이후에 API Call을 하는 방식으로 해결했습니다.

- 사용한 Package는 다음과 같습니다. 
- provider : 상태관리를 위해 사용하였습니다. 완성한 이후에 요구조건의 BloC을 사용하라는 문구를 발견하여 수정하지 못했습니다.
- lint : lint 입니다.
- http : api call을 위한 http입니다.
- qr_code_scanner : QR스캔을 위한 QR스캐너입니다.
- permission_handler : 카메라 접근권한을 위해 사용했습니다.
- url_launcher : QR로 스캔한 이후, url을 가지고 WebView를 쏴주기 위해 사용했습니다.
- go_router : 내장 Navigator를 사용하려다가 parameter전달을 편하게 하기 위해 사용했는데, 설계가 바뀌어 크게 사용하지 않았습니다.
- pull_to_refresh : 편하다고 해서 한번 써봤는데 잘 모르겠습니다.

- commit message는 상용되는 commit message rule을 참고하였습니다.


- HomeView의 수업 카드에 InkWell을 입혀놓았으나 onTap의 액션이 결정되지 않아 touch animation이 출력되지 않는 경우가 있습니다.
- QR Scanner가 QR 코드를 읽는데 3~5초의 시간이 걸립니다.
- 전체보기에서 위로 당기면 새로고침이 되고 아래로 당기면 새로운 item이 추가가 됩니다. 애니메이션은 추가하지 않았습니다.
- Free course에서 instructor의 이름이 비정상적으로 긴 경우가 있었으나 확인 결과 통상 20자까지는 overflow가 일어나지 않아 예외처리 하지 않았습니다.
- 전체보기의 카드 또한 InkWell을 입혀놓았으나 touch animation이 출력되지 않습니다.