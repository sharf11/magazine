// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

List<NotificationsModel> notificationsModelFromJson(String str) => List<NotificationsModel>.from(json.decode(str).map((x) => NotificationsModel.fromJson(x)));

String notificationsModelToJson(List<NotificationsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationsModel {
  NotificationsModel({
    required this.id,
    required this.message,
    required  this.userId,
    required this.postId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String message;
  int userId;
  int postId;
  dynamic createdAt;
  dynamic updatedAt;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
    id: json["id"],
    message: json["message"],
    userId: json["user_id"],
    postId: json["post_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "user_id": userId,
    "post_id": postId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
