
import 'package:aram_management/src/model/video_type.dart';
import 'package:http/http.dart' show Client;

class VideoTypeApi {
  final String baseUrl = "http://46.101.250.202/ahmed/aramapi/public";
  Client client = Client();

  Future<List<VideoType>> getVideoTypes() async {
    final response = await client.get("$baseUrl/videotypes/get");
    if (response.statusCode == 200) {
      return videoTypeFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createVideoType(VideoType data) async {
    final response = await client.post(
      "$baseUrl/videoType/post",
      headers: {"content-type": "application/json"},
      body: videoTypeToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateVideoType(VideoType data) async {
    final response = await client.put(
      "$baseUrl/videoType/put/${data.videoTypeId}",
      headers: {"content-type": "application/json"},
      body: videoTypeToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteVideoType(int id) async {
    final response = await client.delete(
      "$baseUrl/videoType/delete/$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
