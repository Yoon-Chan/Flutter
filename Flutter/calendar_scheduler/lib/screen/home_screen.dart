import 'package:calendar_scheduler/component/main_calendar.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/component//schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:calendar_scheduler/model/schedule_model.dart';
import 'package:calendar_scheduler/provider/schedule_provider.dart';
import 'package:calendar_scheduler/screen/banner_ad_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreen();
// }

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  DateTime selectedDate = DateTime.utc(
      //선택된 날짜를 관리할 함수
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day);

  String id = 'c9943a77-8043-4912-a99b-4de5d377911e';

  @override
  Widget build(BuildContext context) {
    // final provider = context.watch<ScheduleProvider>();
    //
    // //선택된 날짜 가져오기
    // final selectedDate = provider.selectedDate;
    //
    // //선택된 날짜에 해당되는 일정들 가져오기
    // final schedules = provider.cache[selectedDate] ?? [];

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: PRIMARY_COLOR,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => ScheduleBottomSheet(
                selectedDate: selectedDate, //선택된 날짜 넘겨주기
              ),
              isDismissible: true, //배경을 탭했을 때 BottomSheet 닫기
              isScrollControlled: true,
            );
          },
          child: Icon(Icons.add),
        ),
        body: SafeArea(
          child: Column(
            children: [
              MainCalendar(
                selectedDate: selectedDate, //선택된 날짜 전달하기

                //날짜가 선택됐을 때 실행할 함수
                onDaySelected: (selectedDate, focusedDate) =>
                    onDaySelected(selectedDate, focusedDate, context),
              ),
              SizedBox(
                height: 8,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('schedule')
                    .where('date',
                    isEqualTo:
                    '${selectedDate.year}${selectedDate.month.toString().padLeft(2, '0')}${selectedDate.day.toString().padLeft(2, '0')}')
                    .snapshots(),

                  builder: (context, snapshot) {
                    return TodayBanner(
                      selectedDate: selectedDate,
                      count: snapshot.data?.docs.length ?? 0, //일정 개수 입력하기
                    );
                  },
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                //파이어 스토어로부터 일정 정보 받아오기
                stream: FirebaseFirestore.instance
                    .collection('schedule')
                    .where('date',
                        isEqualTo:
                            '${selectedDate.year}${selectedDate.month.toString().padLeft(2, '0')}${selectedDate.day.toString().padLeft(2, '0')}')
                    .snapshots(),

                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('일정 정보를 가져오지 못했습니다.'),
                    );
                  }

                  //로딩 중일 때 보여줄 화면
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center();
                  }

                  //ScheduleModel로 데이터 매핑하기
                  //final schedules = List<ScheduleModel>.filled(5, ScheduleModel(id: '1', content: 'content', date: selectedDate, startTime: 12, endTime: 14));

                  final schedules = snapshot.data!.docs
                      .map((e) => ScheduleModel.fromJson(
                          json: e.data() as Map<String, dynamic>))
                      .toList();

                  //final schedules = a.map((e) => ScheduleModel.fromJson( json: e.data()! as Map<String, dynamic>)).toList();
                  //print(ScheduleModel.fromJson(json: a));

                  return ListView.separated(
                    itemCount: schedules.length,

                    separatorBuilder: (context, index) {
                      return BannerAdWidget();
                    },

                    itemBuilder: (context, index) {
                      //현재 index에 해당되는 일절
                      final schedule = schedules[index];
                      return Dismissible(
                        key: ObjectKey(schedule.id),

                        //밀기 방향
                        direction: DismissDirection.startToEnd,

                        //밀기 했을 때 실행할 함수
                        onDismissed: (direction) {
                          FirebaseFirestore.instance
                              .collection('schedule')
                              .doc(schedule.id)
                              .delete();

                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: 8.0, left: 8.0, right: 8.0),
                          child: ScheduleCard(
                            startTime: schedule.startTime,
                            endTime: schedule.endTime,
                            content: schedule.content,
                          ),
                        ),
                      );
                    },
                  );
                },
              ))
            ],
          ),
        ));
  }

  void onDaySelected(
      DateTime selectedDate, DateTime focusedDate, BuildContext context) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}
