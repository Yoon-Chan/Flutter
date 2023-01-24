# 코드팩토리의 플러터 프로그래밍 실습 예제



### 기본 화면 꾸미기 (splash_screen)



화면에 배경 색상 변경, 중앙 정렬, 로고 이미지 삽입, 로딩 원형 애니매이션 적용하는 실습을 진행

[1.webm](https://user-images.githubusercontent.com/56026214/213957452-6a27a0e5-8892-4963-9317-aec3d547c0dc.webm)





---



### 웹앱 사용하기

웹페이지를 WebView를 이용하여 보여주고 앱바와 앱바에 있는 actions를 이용하여 홈 버튼, 앞으로 가기, 뒤로 가기, 버튼을 사용하였다.

[webapp.webm](https://user-images.githubusercontent.com/56026214/213966390-543243c9-44d3-4883-b597-289b3be2bc8e.webm)



---



### 전자액자



이미지 5장을 스와이프를 이용해 이미지가 바뀌고

또한 Timer를 통하여 0.5초마다 이미지가 자동으로 변경되도록 만들었다.

[image.webm](https://user-images.githubusercontent.com/56026214/213974556-d6c02e7e-d207-411b-8836-bc056fec21c1.webm)



----



### 데이트 날짜 세는 앱



초기 화면에는 현재 날짜와 D+1로 표시된 화면이 나타난다.

화면에 있는 하트를 누르게 되면 아래에 시간을 변경 할 수 있는 DatePicker가 나타난다.

(CupertinoDatePicker를 사용하여 기능을 구현했다.)

현재 날짜보다 미래에 있는 날짜는 사용을 하지 못하도록 하였고, 과거에 있는 날짜로 바꾸게 되면,

'우리 처음 만난 날' 문구 아래의 날짜와 D+날짜가 바뀌게 된다.



