import 'dart:convert';


      List<Video> videoFromJson(String str) {
    final data = json.decode(str);
  return List<Video>.from(data.map((item) => Video.fromJson(item)));
  }

String videoToJson(Video data) => json.encode(data.toJson());

class Video {
  
  String videoStatusColor;
  String domainImageUrl;
  String videoProducedBy;
  String videoPublishedBy;
  String videoEditBy;
  String videoVoiceOverBy;
  String videoId;
  String videoTitle;
  String videoTypeName;
  String domainId;
  String videoStatusId;
  String videoTypeId;
  String userName;
  String domainName;
  String videoStatusName;
  DateTime createdAt;
  DateTime updatedAt;

  Video({
    this.videoStatusColor,
    this.domainImageUrl,
    this.videoProducedBy,
    this.videoPublishedBy,
    this.videoEditBy,
    this.videoVoiceOverBy,
    this.videoId,
    this.videoTitle,
    this.videoTypeName,
    this.domainId,
    this.videoStatusId,
    this.videoTypeId,
    this.userName,
    this.domainName,
    this.videoStatusName,
    this.createdAt,
    this.updatedAt,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        videoStatusColor: json["video_status_color"],
        domainImageUrl: json["domain_image_url"],
        videoProducedBy: json["video_produced_by"],
        videoPublishedBy: json["video_published_by"],
        videoEditBy: json["video_edit_by"],
        videoVoiceOverBy: json["video_voiceOver_by"],
        videoId: json["video_id"],
        videoTitle: json["video_title"],
        videoTypeName: json["video_type_name"],
        domainId: json["domain_id"],
        videoStatusId: json["video_status_id"],
        videoTypeId: json["video_type_id"],
        userName: json["user_name"],
        domainName: json["domain_name"],
        videoStatusName: json["video_status_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"]==null?json["updated_at"]: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "video_status_color": videoStatusColor,
        "domain_image_url": domainImageUrl,
        "video_produced_by": videoProducedBy,
        "video_published_by": videoPublishedBy,
        "video_edit_by": videoEditBy,
        "video_voiceOver_by": videoVoiceOverBy,
        "video_id": videoId,
        "video_title": videoTitle,
        "video_type_name": videoTypeName,
        "domain_id": domainId,
        "video_status_id": videoStatusId,
        "video_type_id": videoTypeId,
        "user_name": userName,
        "domain_name": domainName,
        "video_status_name": videoStatusName,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
