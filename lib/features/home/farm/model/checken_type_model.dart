// models/chicken_type_model.dart
class ChickenTypeModel {
  final int id;
  final String chickenTypeName;

  ChickenTypeModel({required this.id,required this.chickenTypeName});

  factory ChickenTypeModel.fromJson(Map<String, dynamic> json) {
    return ChickenTypeModel(
     id: json['chickenTypeId'],
      chickenTypeName: json['chickenTypeName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chickenTypeId': id,
      'chickenTypeName': chickenTypeName,
    };
  }
}
