import 'dart:convert';

List<Category> talentsCategoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String talentsCategoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
    int id;
    String title;
    // int? idReferance;
    // bool isActive;
    // DateTime createdAt;
    // DateTime updatedAt;

    Category({
        required this.id,
        required this.title,
        // this.idReferance,
        // required this.isActive,
        // required this.createdAt,
        // required this.updatedAt,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: json["title"],
        // idReferance: json["id_referance"],
        // isActive: json["is_active"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        // "id_referance": idReferance,
        // "is_active": isActive,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
    };
}
