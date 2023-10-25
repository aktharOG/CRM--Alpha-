// To parse this JSON data, do
//
//     final expenseModel = expenseModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

List<ExpenseModel> expenseModelFromJson(String str) => List<ExpenseModel>.from(json.decode(str).map((x) => ExpenseModel.fromJson(x)));

String expenseModelToJson(List<ExpenseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseModel {
    int id;
    String title;
    int stage;
    String stageName;
    String file;
    String totalExpanse;
    String date;
    int category;

    ExpenseModel({
        required this.id,
        required this.title,
        required this.stage,
        required this.file,
        required this.totalExpanse,
        required this.date,
        required this.category,
        required this.stageName
    });

    factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
        id: json["id"],
        title: json["title"],
        stage: json["stage"],
        file: json["file"]??"/media/ProjectExpanse/Screenshot_2023-06-16_135944_eK0Zogg.png",
        totalExpanse: json["total_expanse"],
        date: DateFormat('dd-MM-yyyy').format(DateTime.parse(json["date"].toString())),
        category: json["category"],
        stageName: json["stage_name"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "stage": stage,
        "file": file,
        "total_expanse": totalExpanse,
        "date": date,
        "category": category,
        "stage_name":stageName
    };
}
