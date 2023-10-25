// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    String image;
    String name;
    String designation;
    String email;
    String employeeId;

    ProfileModel({
        required this.image,
        required this.name,
        required this.designation,
        required this.email,
        required this.employeeId,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        image: json["image"],
        name: json["name"],
        designation: json["designation"],
        email: json["email"],
        employeeId: json["employee_id"],
    );

    Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "designation": designation,
        "email": email,
        "employee_id": employeeId,
    };
}
