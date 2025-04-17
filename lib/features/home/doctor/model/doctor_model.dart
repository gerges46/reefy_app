
class Doctor {
  final int userId;
  final String userName;
  final String email;
  final String? phone;
  final String? address;
  final String? region;
  final String? governorate;
  final int roleId;
  final String? roleName; // ← خليه nullable
  final String? token;

  Doctor({
    required this.userId,
    required this.userName,
    required this.email,
    this.phone,
    this.address,
    this.region,
    this.governorate,
    required this.roleId,
    this.roleName, // ← خليه optional
    this.token,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      userId: json['userId'],
      userName: json['userName'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      region: json['region'],
      governorate: json['governorate'],
      roleId: json['roleId'],
      roleName: json['roleName'], // ← ممكن تكون null
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'email': email,
      'phone': phone,
      'address': address,
      'region': region,
      'governorate': governorate,
      'roleId': roleId,
      'roleName': roleName,
      'token': token,
    };
  }
}

