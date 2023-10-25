import 'dart:convert';

import 'package:intl/intl.dart';

List<ProjectModel> projectModelFromJson(String str) => List<ProjectModel>.from(
    json.decode(str).map((x) => ProjectModel.fromJson(x)));

String projectModelToJson(List<ProjectModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectModel {
  int id;
  String name;
  String image;
  String location;
  String projectType;
  String description;
  String currency;
  String totalBudget;
  String startDate;
  String endDate;
  dynamic client;
  String slug;
  double progress;
  int count;

  ProjectModel({
    required this.id,
    required this.name,
    required this.image,
    required this.location,
    required this.projectType,
    required this.description,
    required this.currency,
    required this.totalBudget,
    required this.startDate,
    required this.endDate,
    required this.client,
    required this.slug,
    required this.progress,
    required this.count,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        image: json["image"] ??
            "https://www.shutterstock.com/shutterstock/photos/2016049079/display_1500/stock-photo-worker-with-contruction-iron-lines-for-building-foundation-construction-worker-2016049079.jpg",
        location: json["location"] ?? '',
        projectType: json["project_type"] ?? '',
        description: json["description"] ?? '',
        currency: json["currency"] ?? '',
        totalBudget: json["total_budget"] ?? '',
        startDate: DateFormat('dd-MM-yyyy').format(DateTime.parse(json["start_date"].toString())),
        endDate: DateFormat('dd-MM-yyyy').format(DateTime.parse(json["end_date"].toString())),
        client: json["client"] ?? '',
        slug: json["slug"] ?? '',
        progress: json["progress"] ?? 0.0,
        count: json["count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "location": location,
        "project_type": projectType,
        "description": description,
        "currency": currency,
        "total_budget": totalBudget,
        "start_date": startDate,
        "end_date": endDate,
        "client": client,
        "slug": slug,
        "progress": progress,
        "count": count,
      };
}
