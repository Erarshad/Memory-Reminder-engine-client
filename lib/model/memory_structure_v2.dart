// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

List<ProfileV2> profileFromJson(String str) => List<ProfileV2>.from(json.decode(str).map((x) => ProfileV2.fromJson(x)));

String profileToJson(List<ProfileV2> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfileV2 {
    String email;
    String title;
    String description;
    String? eventdate;
    String? lastSentDate;
    String dateAdded;
    String? tags;
    String? image64;
    int id;

    ProfileV2({
        required this.email,
        required this.title,
        required this.description,
         this.eventdate,
        this.lastSentDate,
        required this.dateAdded,
         this.tags,
         this.image64,
        required this.id,
    });

    factory ProfileV2.fromJson(Map<String, dynamic> json) => ProfileV2(
        email: json["email"],
        title: json["title"],
        description: json["description"],
        eventdate: json["eventdate"],
        lastSentDate: json["lastSentDate"],
        dateAdded: json["dateAdded"],
        tags: json["tags"],
        image64: json["image64"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "title": title,
        "description": description,
        "eventdate": eventdate??"",
        "lastSentDate": lastSentDate??"",
        "dateAdded": dateAdded,
        "tags": tags??"",
        "image64": image64??"",
        "id": id,
    };
}
