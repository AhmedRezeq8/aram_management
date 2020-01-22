// To parse this JSON data, do
//


import 'dart:convert';

  List<VideoType> videoTypeFromJson(String str) {
    final data = json.decode(str);
  return List<VideoType>.from(data.map((item) => VideoType.fromJson(item)));
  }
String videoTypeToJson(VideoType data) => json.encode(data.toJson());

class VideoType {
    String videoTypeId;
    String videoTypeName;

    VideoType({
        this.videoTypeId,
        this.videoTypeName,
    });

    factory VideoType.fromJson(Map<String, dynamic> json) => VideoType(
        videoTypeId: json["video_type_id"],
        videoTypeName: json["video_type_name"],
    );

    Map<String, dynamic> toJson() => {
        "video_type_id": videoTypeId,
        "video_type_name": videoTypeName,
    };
    
}
