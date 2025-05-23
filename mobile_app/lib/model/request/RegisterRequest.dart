class RegisterRequest {
  final String phone;
  final String name;
  final String address;
  final String password;
  final String confirmPassword;

  RegisterRequest({
    required this.phone,
    required this.name,
    required this.address,
    required this.password,
    required this.confirmPassword,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      phone: json['phone'],
      name: json['name'],
      address: json['address'],
      password: json['password'],
      confirmPassword: json['confirm_password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "phone": phone,
      "name": name,
      "address": address,
      "password": password,
      "confirm_password": confirmPassword,
    };
  }
}
