import 'dart:convert';

class StatusModel {

   final int id;
   final String status;
  StatusModel({
    required this.id,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'status': status});
  
    return result;
  }

  factory StatusModel.fromMap(Map<String, dynamic> map) {
    return StatusModel(
      id: map['id']?.toInt() ?? 0,
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusModel.fromJson(String source) => StatusModel.fromMap(json.decode(source));
}
