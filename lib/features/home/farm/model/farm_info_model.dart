
// class FarmModel {
//   //final int id;
//   final String farmName;
//   final String address;
//   final String region;
//   final String governorate;
//   final int userId;

//   FarmModel({
//     //required this.id,
//     required this.farmName,
//     required this.address,
//     required this.region,
//     required this.governorate,
//     required this.userId,
//   });

//   // Factory Constructor لتحويل JSON إلى كائن FarmModel
//   factory FarmModel.fromJson(Map<String, dynamic> json) {
//     return FarmModel(
//     //  id: json['id'],
//       farmName: json['farmName'],  // التأكد من أن المفتاح مطابق للـ API
//       address: json['address'],
//       region: json['region'],
//       governorate: json['governorate'],
//       userId: json['userId'],
//     );
//   }

//   // لتحويل الكائن إلى JSON عند الإرسال للـ API
//   Map<String, dynamic> toJson() {
//     return {
//     //  'id': id,
//       'farmName': farmName,
//       'address': address,
//       'region': region,
//       'governorate': governorate,
//       'userId': userId,
//     };
//   }
// }
class FarmModel {
  final int? farmId;
  final String farmName;
  final String address;
  final String region;
  final String governorate;
  final int userId;
  final UserModel? user;

  FarmModel({
    this.farmId,
    required this.farmName,
    required this.address,
    required this.region,
    required this.governorate,
    required this.userId,
    this.user,
  });

  factory FarmModel.fromJson(Map<String, dynamic> json) {
    return FarmModel(
      farmId: json['farmId'],
      farmName: json['farmName'],
      address: json['address'],
      region: json['region'],
      governorate: json['governorate'],
      userId: json['userId'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'farmName': farmName,
      'address': address,
      'region': region,
      'governorate': governorate,
      'userId': userId,
    };
  }
}

class UserModel {
  final int userId;
  final String userName;
  final String email;
  final String phone;
  final String address;
  final String region;
  final String governorate;

  UserModel({
    required this.userId,
    required this.userName,
    required this.email,
    required this.phone,
    required this.address,
    required this.region,
    required this.governorate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      userName: json['userName'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      region: json['region'],
      governorate: json['governorate'],
    );
  }
}


