
import 'dart:convert';

// VideoStatus videoStatusFromJson(String str) => VideoStatus.fromJson(json.decode(str));
     List<VideoStatus> videoStatusFromJson(String str) {
    final data = json.decode(str);
  return List<VideoStatus>.from(data.map((item) => VideoStatus.fromJson(item)));
  }
String videoStatusToJson(VideoStatus data) => json.encode(data.toJson());

class VideoStatus {
    String videoStatusId;
    String videoStatusName;
    String videoStatusColor;

    VideoStatus({
        this.videoStatusId,
        this.videoStatusName,
        this.videoStatusColor,
    });

    factory VideoStatus.fromJson(Map<String, dynamic> json) => VideoStatus(
        videoStatusId: json["video_status_id"],
        videoStatusName: json["video_status_name"],
        videoStatusColor: json["video_status_color"],
    );

    Map<String, dynamic> toJson() => {
        "video_status_id": videoStatusId,
        "video_status_name": videoStatusName,
        "video_status_color": videoStatusColor,
    };
}
