// To parse this JSON data, do
//
//     final storiesModel = storiesModelFromJson(jsonString);

import 'dart:convert';

StoriesModel storiesModelFromJson(String str) =>
    StoriesModel.fromJson(json.decode(str));

String storiesModelToJson(StoriesModel data) => json.encode(data.toJson());

class StoriesModel {
  bool error;
  String message;
  List<ListStory> listStory;

  StoriesModel({
    required this.error,
    required this.message,
    required this.listStory,
  });

  factory StoriesModel.fromJson(Map<String, dynamic> json) => StoriesModel(
        error: json["error"],
        message: json["message"],
        listStory: List<ListStory>.from(
            json["listStory"].map((x) => ListStory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "listStory": List<dynamic>.from(listStory.map((x) => x.toJson())),
      };
}

class ListStory {
  String id;
  String name;
  String description;
  String photoUrl;
  DateTime createdAt;

  ListStory({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
  });

  factory ListStory.fromJson(Map<String, dynamic> json) => ListStory(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        photoUrl: json["photoUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "photoUrl": photoUrl,
        "createdAt": createdAt.toIso8601String(),
      };
}
