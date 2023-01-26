import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatelessWidget {
  static final LatLng companyLatLng = LatLng(37.5233273, 126.921252);
  static final Marker marker =
  Marker(markerId: MarkerId("company"), position: companyLatLng);
  static final Circle circle = Circle(
    circleId: CircleId("choolCheckCircle"),
    center: companyLatLng,
    fillColor: Colors.blue.withOpacity(0.5),
    radius: 100,
    strokeColor: Colors.blue,
    strokeWidth: 1,
  );

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: renderAppBar(),
        body: FutureBuilder<String>(
          future: checkPermission(),
          builder: (context, snapshot) {
            //로딩 상태
            if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            //권한 허가된 상태
            if (snapshot.data == '위치 권한이 허가 되었습니다.') {
              return Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: companyLatLng,
                        zoom: 16, //확대 정도 (높을수록 크게 보임)
                      ),
                      markers: Set.from([marker]),
                      circles: Set.from([circle]),

                      // 내 위치 지도에 보여주기
                      myLocationEnabled: true,
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.timelapse_outlined,
                            color: Colors.blue,
                            size: 50,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final curPosition = await Geolocator
                                  .getCurrentPosition(); //현재 위치

                              final distance = Geolocator.distanceBetween(
                                  curPosition.latitude, curPosition.longitude,
                                  companyLatLng.latitude,
                                  companyLatLng.longitude);

                              bool check = distance <
                                  100; // 100미터 이내에 있으면 출근 가능

                              showDialog(context: context, builder: (_) {
                                return AlertDialog(
                                  title: Text("출근하기"),

                                  //출근 가능 여부에 따라 다른 메시지 제공
                                  content: Text(
                                      check ? '출근을 하시겠습니까?' : '출근 할 수 없는 위치입니다.'
                                  ),
                                  actions: [
                                    TextButton(onPressed: () {
                                      Navigator.of(context).pop(false);
                                    }, child: Text('취소')),

                                    if(check)
                                      TextButton(onPressed: () {
                                        Navigator.of(context).pop(true);
                                      }, child: Text("출근하기")),
                                  ],
                                );
                              });
                            },
                            child: Text('출근하기!'),
                          ),
                        ],
                      )),
                ],
              );
            }

            //권한이 없는 상태
            return Center(
              child: Text(
                snapshot.data.toString(),
              ),
            );
          },
        ));
  }

  AppBar renderAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        '오늘도 출첵',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Future<String> checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    //위치 서비스 활성화 여부 확인
    if (!isLocationEnabled) {
      return '위치 서비스를 활성화해주세요.';
    }

    LocationPermission checkPermission = await Geolocator.checkPermission();

    //위치 권한 확인
    if (checkPermission == LocationPermission.denied) {
      //위치 권한 거절

      //위치 권한 요청
      checkPermission = await Geolocator.requestPermission();

      if (checkPermission == LocationPermission.denied) {
        return '위치 권한을 허가해주세요';
      }

      // 위치 권한 거절됨(앱에서 재요청 불가)
      if (checkPermission == LocationPermission.deniedForever) {
        return '앱의 위치 권한을 설정에서 허가해주세요.';
      }
    }

    //위 모든 조건이 통과되면 위치 권한 허가 완료
    return '위치 권한이 허가 되었습니다.';
  }
}
