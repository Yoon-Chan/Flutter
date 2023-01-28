import 'dart:convert';

import 'package:cf_tube/component/api.dart';
import 'package:cf_tube/model/video_model.dart';
import 'package:dio/dio.dart';

class YoutubeRepository {
  static Future<List<VideoModel>> getVideo() async {
    final resp = await Dio().get(
      // GET  메서드 보내기
      YOUTUBE_API_BASE_URL, // 요청을 보낼 URL
      queryParameters: {
        'channelId': CF_CHANNEL_ID,
        'maxResults': 50,
        'key': API_KEY,
        'part': 'snippet',
        'order': 'date',
      },
    );

    final listWithData = resp.data['items'].where(
      (item) =>
          item?['id']?['videoId'] != null && item?['snippet']?['title'] != null,
    );

    return listWithData
        .map<VideoModel>(
          (item) => VideoModel(
            id: item['id']['videoId'],
            title: item['snippet']['title'],
          ),
        )
        .toList();
  }
}
