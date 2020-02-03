import 'dart:convert';


List<User> userFromJson(String str) {
  final data = json.decode(str);
  return List<User>.from(data.map((item) => User.fromJson(item)));
}
User userrFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String userId;
    String userName;
    String userEmail;
    String userTypeId;
    String userPassword;
    String userImage;
    String userTypeName;

    User({
        this.userId,
        this.userName,
        this.userEmail,
        this.userTypeId,
        this.userPassword,
        this.userImage,
        this.userTypeName,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        userName: json["user_name"],
        userEmail: json["user_email"],
        userTypeId: json["user_type_id"],
        userPassword: json["user_password"],
        userImage: json["user_image"],
        userTypeName: json["user_type_name"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "user_email": userEmail,
        "user_type_id": userTypeId,
        "user_password": userPassword,
        "user_image": userImage,
        "user_type_name": userTypeName,
    };
}
