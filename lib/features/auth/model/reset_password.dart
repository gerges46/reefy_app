class ResetPassword {
  final String message;
  final String? data;

  ResetPassword({required this.message, this.data});

  factory ResetPassword.fromJson(Map<String, dynamic> json) {
    return ResetPassword(
      message: json['message'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data,
    };
  }
}

