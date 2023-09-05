// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  String? email;
  String title;
  String description;
  String? eventDate;
  String? lastSentDate;
  String? dateAdded;
  List<String>? tags;
  String? image64;

  Profile({
    required this.email,
    required this.title,
    required this.description,
    this.eventDate,
    this.tags,
    this.image64,
    this.lastSentDate,
    this.dateAdded
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        email: json["email"],
        title: json["title"],
        description: json["Description"],
        eventDate: json["Event date"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        image64: json["image64"],
        lastSentDate: json["lastSentDate"],
        dateAdded: json["dateAdded"]
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "title": title,
        "Description": description,
        "Event date": eventDate,
        "tags": List<dynamic>.from(tags ?? [].map((x) => x)),
        "image64": image64,
        "lastSentDate":lastSentDate,
        "dateAdded":dateAdded
      };
}
