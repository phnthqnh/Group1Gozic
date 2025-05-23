class LoginRequest {
  final String user_phone;
  final String password;

  LoginRequest({required this.user_phone, required this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      user_phone: json['user_phone'],
      password: json['password'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {"user_phone": user_phone, "password": password};
  }
}
