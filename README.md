# Flutter
플러터 공부

Flutter : CodeFactory 책 플러터 실습 

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



+ #### 영상1 - 에뮬레이터

  

[1.webm](https://user-images.githubusercontent.com/56026214/214742930-c227944b-5b99-49f5-a4d2-dc1c5bd23c7d.webm)

  

+ #### 영상 2 - 실제 기기 



https://user-images.githubusercontent.com/56026214/214742977-a378a4fc-4917-4971-8d47-acbd9e9be4e4.mp4



하나는 에뮬레이터를 하나는 가지고 있는 기기를 이용하여 서로 영상통화가 가능한지를 확인 하였다.

둘 중 서로 한 명이 연결이 안되어 있다면 다른 사용자가 입장할 때 까지 기다린다.

이후 다른 기기가 접속을 하게 되면 서로 영상을 보여주고 통화가 가능해진다.

또한 둘 중 한명이 나간다면 다시 다른 사용자가 입장할 때까지 기다리게 된다.



------



### 회사 지도를 이용한 출근 체크 기눙



구글 지도  API를 이용하여 지도를 보여주고, 현재 위치와 회사 위치가 맞지 않으면 출근이 불가능 하며, 회사 100m 이내에 있으면 출근이 가능하게 하는 앱을 만들었다.



| 시작 화면 | 메인 화면 | 회사 바께 출근하기 버튼 | 회사 내에 있는 경우 |
| :-------: | :-------: | :---------------------: | :-----------------: |
|      ![1](https://user-images.githubusercontent.com/56026214/215262108-b45a924d-9a7f-4863-8ee9-81814f4cf214.png)|     ![2](https://user-images.githubusercontent.com/56026214/215262113-3be6c481-680e-4944-89fd-3f1b7db2cac1.png)|![3](https://user-images.githubusercontent.com/56026214/215262117-923ac749-1247-42b4-8f9f-804ae8bcaf3a.png)|![4](https://user-images.githubusercontent.com/56026214/215262122-62e3fd18-473a-403a-9b8c-9d611d99f08d.png)|



1. 시작 화면에 해당 앱에 대한 권한이 나오게 된다. 권한 허용을 취소하게 앱 설정에서 권한 설정을 해야한다.
   권한 설정을 하게 되면 다음 구글 지도를 보여준다.
2. 권한 설정을 허가하면 지도와 아래에 출근하기 버튼이 주어진다. 지도는 회사 위치와 반경 100m 이내의 원을 보여준다. 해당 원 안에 있으면 출근을 할 수 있게 된다.
3. 회사 밖에 출근하기 버튼을 눌렀을 때 다이얼로그다. 출근할 수 없는 위치라는 단어가 나오면 취소 버튼을 누르면 다시 메인화면으로 돌아간다.
4. 이번엔 회사 내에 있는 경우이다. 현재 위치를 회사 내에 조정을 하고 다시 출근하기 버튼을 누르면 회사 밖에 있는 경우와 다르게 다이얼로그가 뜨는 것을 볼 수 있다.



구글 지도에 보이는 버튼은 전부 사용이 가능하며 +,- 버튼을 누르면 지도가 확대/축소가 되고, 오른쪽 위 버튼을 누르면 현재 위치로 가게 된다.

출근하기 버튼을 눌러도 아무 기능이 없다. (이후 구현 x)

+ 실행 영상


https://user-images.githubusercontent.com/56026214/215262137-9d7fb626-bfaa-4eef-a084-8d432fdf4cd0.mp4



----



### 이미지 꾸미기 기능



이미지를 선택하고 이미지에 스티커를 붙여서 꾸미는 어플을 제작한다.



ImagePicker와 InteractiveViewer 위젯, 그리 GestureDetector를 이용하여 구현하였다.





| 시작 화면 | 갤러리 화면 | 이미지가 선택한 화면 | 이미지 꾸미기|
| --------- | ----------- | -------------------- |-------------|
|    ![1](https://user-images.githubusercontent.com/56026214/215262920-16291ced-b97c-47b3-a620-9c8dac3a12b3.png)|        ![2](https://user-images.githubusercontent.com/56026214/215262924-501d630b-e6f0-4638-a2b4-49be67a44c9d.png)|             ![3](https://user-images.githubusercontent.com/56026214/215262928-035c3e48-8e4d-4123-9ed1-5f4e8b756c0e.png)          | ![4](https://user-images.githubusercontent.com/56026214/215262944-f9fef139-533e-42af-9986-605d41c01f86.png)| 

| 삭제 탭 누른 경우 | 저장하 | 저장된 이미지 확인 |
| ----------------- | ----------- | ------------------ |
|         ![5](https://user-images.githubusercontent.com/56026214/215262953-a525c00d-d4f3-4c6a-bbe7-3f1f3fd58557.png)|        ![6](https://user-images.githubusercontent.com/56026214/215262964-c37fd042-c955-4455-b179-dcf93026ef13.png)|       ![7](https://user-images.githubusercontent.com/56026214/215262970-fe28d7f2-2d6b-4d9a-993f-aaafe5da0338.png)|



1. 시작하면 위에 탭 3개와 가운데에 이미지 선택하기가 있다. 탭 왼쪽 버튼 또는 이미지 선택하기를 누르면 갤러리, 이미지를 선택하는 화면으로 이동한다.
2.  해당 화면에는 에뮬레이터에 사진 1개를 다운로드 해놓았다. 해당 사진을 누르면 선택한 이미지가 나오게 된다.
3. 이미지를 선택하면 위와 같이 화면이 나온다. 선택한 사진 그리고 아래에는 이모티콘들이 있다. 이모티콘 선택에는 SingleChildScrollView를 구현하여 가로로 스와이프를 이용해 이동할 수 있다. 이미지를 선택하면 가운데에 이미지가 나오게 된다.
4.  가운데 탭인 삭제를 누르면 최근에 올린 이모티콘이 삭제되게 된다.
5. 오른쪽 탭을 누르게 되면 꾸민 사진을 저장할 수 있다. 저장된 사진은 다시 왼쪽 탭을 눌러서 확인할 수 있다.



+ 실행 영상





https://user-images.githubusercontent.com/56026214/215262973-6e1cc0dc-6d34-4287-8760-5c4f8c599623.mp4





-----

### 유튜브 기본 구현



구글 유튜브 API를 사용해서 유튜브 채널의 영상들을 불러와 보여주는 앱을 만든다.



REST Api의 Dio를 사용하고 구글 유튜브 API의 데이터를 Json 형식으로 받아오고 받아온 유튜브 영상들을 보여주도록 하였다.



구글 유튜브 Api 기능인 YoutubePlayerController, YoutubePlayerFlags, YoutubePlayer를 이용하여 유튜브 데이터를 얻어왔다.



시작 하면 설정한 채널의  유튜브의 영상들이 나온다. ListView를 이용하여 스와이프하면 해당 영상들이 나온다.

위로 당기게 되면 새로고침 기능 실행되도록 한다. 새로고침 기능은 RefreshIndicator기능을 이용하여 구현하였다.





+ 실행 영상



https://user-images.githubusercontent.com/56026214/215263992-c21437ec-b7de-47e9-9dfa-078cf5cc40a7.mp4



---

## 📅 일정 관리 앱 프로젝트

### 🚩프로젝트 개요

+ 내부 데이터를 저장하는 방식으로 일정 관리 앱 프로젝트입니다.

### 📖 프로젝트 노션

https://www.notion.so/Calendar-Scheduler-14ecf49ae17a489d9d81e8cd99ad769a



### 👨‍💻 프로젝트 코드

https://github.com/Yoon-Chan/Flutter_Learn/tree/main/Flutter3.0/calendar_scheduler

### 📌 프로젝트 기술 스택

+ Table Calendar
+ Drift
+ Dismissible
+ BottomSheet
+ Form



### 🚀 앱 실행 영상

일정을 생성, 수정,삭제 기능을 영상입니다.

달력에 해당 날짜를 선택하고 아래 플로팅 버튼을 누르면 일정을 생성하는 화면이 나옵니다.

일정을 생성하면 달력 아래에 일정이 나오며, 왼쪽으로 스와이프 시 삭제를, 탭을 누르면 일정 변경 화면이 나오게 됩니다.

| 일정 생성 | 일정 수정 | 일정 삭제 |
| --------- | --------- | --------- |
|       ![create_schedule](https://github.com/Yoon-Chan/Flutter_Learn/assets/56026214/0f60c70f-4b53-4696-be27-374c8c63a54e)|    ![update_schedule](https://github.com/Yoon-Chan/Flutter_Learn/assets/56026214/1e466c10-9fba-4b21-811c-8e7c8835a0bf) |     ![schedule_delete](https://github.com/Yoon-Chan/Flutter_Learn/assets/56026214/87102277-65ff-401b-b406-e2ddfbfbfa81) |

