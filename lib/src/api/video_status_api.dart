
import 'package:aram_management/src/model/video_status.dart';
import 'package:http/http.dart' show Client;

class VideoStatusApi {
  final String baseUrl = "http://46.101.250.202/ahmed/aramapi/public";
  Client client = Client();

  Future<List<VideoStatus>> getVideoStatuss() async {
    final response = await client.get("$baseUrl/videostatuses/get");
    if (response.statusCode == 200) {
      return videoStatusFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createVideoStatus(VideoStatus data) async {
    final response = await client.post(
      "$baseUrl/videostatus/post",
      headers: {"content-type": "application/json"},
      body: videoStatusToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateVideoStatus(VideoStatus data) async {
    final response = await client.put(
      "$baseUrl/videostatus/put/${data.videoStatusId}",
      headers: {"content-type": "application/json"},
      body: videoStatusToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteVideoStatus(int id) async {
    final response = await client.delete(
      "$baseUrl/videostatus/delete/$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
