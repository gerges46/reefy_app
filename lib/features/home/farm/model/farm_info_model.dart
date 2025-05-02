// class FarmModel {
//   final int id;
//   final String name;

//   FarmModel({required this.id, required this.name});

//   // Factory Constructor لتحويل JSON لـ Object
//   factory FarmModel.fromJson(Map<String, dynamic> json) {
//     return FarmModel(
//       id: json['id'],
//       name: json['name'],
//     );
//   }

//   // لتحويل Object إلى JSON لو احتجت تبعته للـ API
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//     };
//   }
// }
class FarmModel {
  //final int id;
  final String farmName;
  final String address;
  final String region;
  final String governorate;
  final int userId;

  FarmModel({
    //required this.id,
    required this.farmName,
    required this.address,
    required this.region,
    required this.governorate,
    required this.userId,
  });

  // Factory Constructor لتحويل JSON إلى كائن FarmModel
  factory FarmModel.fromJson(Map<String, dynamic> json) {
    return FarmModel(
    //  id: json['id'],
      farmName: json['farmName'],  // التأكد من أن المفتاح مطابق للـ API
      address: json['address'],
      region: json['region'],
      governorate: json['governorate'],
      userId: json['userId'],
    );
  }

  // لتحويل الكائن إلى JSON عند الإرسال للـ API
  Map<String, dynamic> toJson() {
    return {
    //  'id': id,
      'farmName': farmName,
      'address': address,
      'region': region,
      'governorate': governorate,
      'userId': userId,
    };
  }
}

