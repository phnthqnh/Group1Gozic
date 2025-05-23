class RegisterResponse {
  final int id;
  final String phone;
  final String name;
  final String address;
  final String password;
  final String confirmPassword;

  RegisterResponse({
    required this.id,
    required this.phone,
    required this.name,
    required this.address,
    required this.password,
    required this.confirmPassword,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      id: json['id'],
      phone: json['phone'],
      name: json['name'],
      address: json['address'],
      password: json['password'],
      confirmPassword: json['confirm_password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "phone": phone,
      "name": name,
      "address": address,
      "password": password,
      "confirm_password": confirmPassword,
    };
  }
}
