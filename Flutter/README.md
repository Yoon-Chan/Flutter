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



[UandI.webm](https://user-images.githubusercontent.com/56026214/214497986-466e39af-16c4-4408-9c76-cb69c6c0e1d6.webm)


---



### 주사위 던지기



흔들면 주사위가 바뀌는 기능을 구현한 앱이다.

흔들기 감지는 Shake 패키지의 ShakeDetector를 이용하였다.

초기 화면에는 숫자 1의 주사위와 아래에는 내비게이션 바 2개가 있다.

스와이프를 통해 탭이동이 가능하며, 내비게이션 바를 눌러서 이동도 가능하다.

설정 탭에서는 민감도를 조정할 수 있다. 민감도를 높일수록 작은 흔들림에도 감지가 되도록 했다.


| 시작 화면| 설정 | 흔들기 결과 |
| :--: | :--: | :--: |
|![Screenshot_20230125_155154](https://user-images.githubusercontent.com/56026214/214499935-d969d69f-197b-4c26-a7e1-cd6a120cdf55.jpg)|![Screenshot_20230125_155200](https://user-images.githubusercontent.com/56026214/214499948-909373de-53d7-450e-9611-50f8d43a72cd.jpg)| ![Screenshot_20230125_155255](https://user-images.githubusercontent.com/56026214/214499963-506d7b29-3793-43c5-821f-7daaa4e5349c.jpg)|

+ #### 영상

https://user-images.githubusercontent.com/56026214/214499992-b58285e5-b794-46b8-9771-8e6476416b3d.mp4




----



### 비디오 재생 기능



시작 화면에 로고를 클릭하게 되면 핸드폰 내에 있는 비디오 파일을 선택하는 화면이 나온다.

비디오 파일을 선택하면 해당 비디오가 열리며 실행된다.

비디오 화면에 맞게 화면이 나오며 화면을 누르면 뒤로가기, 실행/정지, 앞으로 가기 그리고 우측 위에 다른 비디오 선택하는 아이콘이 나온다. 

핸드폰 회전하면 그에 맞게 비디오 크기가 정해진다.



| 시작 화면 | 로고를 눌렀을 때 | 비디오를 선택했을 때 |
| :-------: | :--------------: | :------------------: |
|   ![1](https://user-images.githubusercontent.com/56026214/214498024-a3e10ee5-9efe-47ec-bcb9-b9bd590956a6.png)|          ![2](https://user-images.githubusercontent.com/56026214/214498034-17a913eb-316f-42a9-a8fd-b24249a7a1b0.png)|            ![3](https://user-images.githubusercontent.com/56026214/214498050-0f9c4e60-e318-445d-bcb0-9f1bd2079649.png)|



| 화면을 회전 했을 때 | 화면 터치했을 때 | 시작 누를 때 |
| :-----------------: | :--------------: | :----------: |
|         ![6](https://user-images.githubusercontent.com/56026214/214498064-aefc3b92-0216-480c-9ef1-4bdbd2ac193b.png)|          ![4](https://user-images.githubusercontent.com/56026214/214498081-658b2adf-3cf6-4d40-ab45-b411856cce34.png)|  ![5](https://user-images.githubusercontent.com/56026214/214498093-46971a4b-731f-4fc4-8ad4-64950fee8660.png)|

 + #### 영상1
[video1.webm](https://user-images.githubusercontent.com/56026214/214498205-bc5abd93-ada8-4297-9d8f-6ffac1a45528.webm)

 + #### 영상2
[video2.webm](https://user-images.githubusercontent.com/56026214/214498221-20facc04-cc7c-4568-bd1b-1462dba958c4.webm)

 + #### 영상3
[video3.webm](https://user-images.githubusercontent.com/56026214/214498820-a589b297-c74d-4927-ac88-8d65a6818778.webm)


----



### 영상통화 기능 앱



영상통화 기능을 구현하였다.

아고라  API를 사용하여 WebRTC 기술을 사용하였다. WebRtC는 현대에서 영상 통화에 가장 많이 사용하는 오픈 소스 프로토콜이다. 오디오 통화, 비디오 통신 그리고 P2P 파일을 공유할 수 있다.



영상통화를 하려면 권한 설정을 해야한다. 마이크 권한과 카메라 권한은 권한 설정 요청을 필수로 해야 하기 때문에 권한 설정에 관련 기능을 구현했다.



+ #### 영상1

  

  

+ #### 영상 2



하나는 에뮬레이터를 하나는 가지고 있는 기기를 이용하여 서로 영상통화가 가능한지를 확인 하였다.

둘 중 서로 한 명이 연결이 안되어 있다면 다른 사용자가 입장할 때 까지 기다린다.

이후 다른 기기가 접속을 하게 되면 서로 영상을 보여주고 통화가 가능해진다.

또한 둘 중 한명이 나간다면 다시 다른 사용자가 입장할 때까지 기다리게 된다.



