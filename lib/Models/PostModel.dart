// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

List<PostModel> postModelFromJson(String str) => List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

String postModelToJson(List<PostModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostModel {
  PostModel({
    required this.id,
    required this.content,
    required  this.youLiked,
    required this.likesCount,
    required this.user,
    required this.comments,
    required  this.likes,
    required  this.createdAt,
  });

  int id;
  String content;
  bool youLiked;
  int likesCount;
  User user;
  List<Comment> comments;
  List<Like> likes;
  String createdAt;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json["id"],
    content: json["content"],
    youLiked: json["you_liked"],
    likesCount: json["likes_count"],
    user: User.fromJson(json["user"]),
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    likes: List<Like>.from(json["likes"].map((x) => Like.fromJson(x))),
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "you_liked": youLiked,
    "likes_count": likesCount,
    "user": user.toJson(),
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
    "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
    "created_at": createdAt,
  };
}

class Comment {
  Comment({
    required  this.id,
    required  this.content,
    required  this.youLiked,
    required  this.user,
    required  this.likesCount,
    required  this.likes,
    required  this.createdAt,
  });

  int id;
  String content;
  bool youLiked;
  User user;
  int likesCount;
  List<dynamic> likes;
  String createdAt;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    content: json["content"],
    youLiked: json["you_liked"],
    user: User.fromJson(json["user"]),
    likesCount: json["likes_count"],
    likes: List<dynamic>.from(json["likes"].map((x) => x)),
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "you_liked": youLiked,
    "user": user.toJson(),
    "likes_count": likesCount,
    "likes": List<dynamic>.from(likes.map((x) => x)),
    "created_at": createdAt,
  };
}

class User {
  User({
    required this.id,
    required  this.name,
    this.photo,
    required  this.type,
    required  this.email,
    required  this.phone,
  });

  int id;
  String name;
  dynamic photo;
  String type;
  String email;
  dynamic phone;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    photo: json["photo"],
    type: json["type"],
    email: json["email"],
    phone: json["phone"] == null ? null : json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photo": photo,
    "type": type,
    "email": email,
    "phone": phone == null ? null : phone,
  };
}





class Like {
  Like({
    required  this.id,
    required  this.user,
  });

  int id;
  User user;

  factory Like.fromJson(Map<String, dynamic> json) => Like(
    id: json["id"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user.toJson(),
  };
}


