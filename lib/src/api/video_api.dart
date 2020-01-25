
import 'package:aram_management/src/model/video.dart';
import 'package:http/http.dart' show Client;

class VideoApi {
  final String baseUrl = "http://46.101.250.202/ahmed/aramapi/public";
  Client client = Client();

  Future<List<Video>> getVideos() async {
    final response = await client.get("$baseUrl/videos/get");
    if (response.statusCode == 200) {
      return videoFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createVideo(Video data) async {
    final response = await client.post(
      "$baseUrl/video/post",
      headers: {"content-type": "application/json"},
      body: videoToJson(data),
    );
    if (response.statusCode == 201||response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateVideo(Video data) async {
    final response = await client.put(
      "$baseUrl/video/put/${data.videoId}",
      headers: {"content-type": "application/json"},
      body: videoToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteVideo(String id) async {
    final response = await client.delete(
      "$baseUrl/video/delete/$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
