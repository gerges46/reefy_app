class UserFarmModel {
  final String farmName;
  final String farmAddress;
  final String farmRegion;
  final String farmGovernorate;

  final String ownerName;
  final String? ownerPhone;
  final String? ownerAddress;
  final String? ownerRegion;
  final String? ownerGovernorate;

  UserFarmModel({
    required this.farmName,
    required this.farmAddress,
    required this.farmRegion,
    required this.farmGovernorate,
    required this.ownerName,
    this.ownerPhone,
    this.ownerAddress,
    this.ownerRegion,
    this.ownerGovernorate,
  });

  factory UserFarmModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {};
    return UserFarmModel(
      farmName: json['farmName'] ?? '',
      farmAddress: json['address'] ?? '',
      farmRegion: json['region'] ?? '',
      farmGovernorate: json['governorate'] ?? '',
      ownerName: user['userName'] ?? '',
      ownerPhone: user['phone'],
      ownerAddress: user['address'],
      ownerRegion: user['region'],
      ownerGovernorate: user['governorate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'farmName': farmName,
      'address': farmAddress,
      'region': farmRegion,
      'governorate': farmGovernorate,
      'user': {
        'userName': ownerName,
        'phone': ownerPhone,
        'address': ownerAddress,
        'region': ownerRegion,
        'governorate': ownerGovernorate,
      }
    };
  }
}
