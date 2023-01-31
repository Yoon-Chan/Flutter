import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({Key? key}) : super(key: key);

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  late final BannerAd banner;

  @override
  void initState() {
    super.initState();

    final adUnitId = Platform.isIOS
        ? 'ca-app-pub-3940256099942544/6300978111'
        : 'ca-app-pub-3940256099942544/6300978111';

    banner = BannerAd(size: AdSize.banner,
        adUnitId: adUnitId,
        listener: BannerAdListener(onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },),
        request: AdRequest());


    banner.load();
  }

  @override
  void dispose() {
    //위젯이 종료되면 배너도 종료된다.
    banner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      //광고의 높이를 지정해준다.
      height: 75,

      //광고 위젯에 banner 변수를 입력해준다
      child: AdWidget(ad: banner,),
    );

  }
}
