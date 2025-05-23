class LoginResponse{
  final int id;
  final String user_phone;
  final String password;

  LoginResponse({
    required this.id,
    required this.user_phone,
    required this.password,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'] ?? 0,
      user_phone: json['user_phone'] ?? "",
      password: json['password'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "user_phone": user_phone, "password": password};
  }
}