class User{
  final String user_phone;
  final String password;

  User({required this.user_phone, required this.password});
  factory User.fromJson(Map<String, dynamic> json){
    return User(
      user_phone: json['user_phone'],
      password: json['password'],
    );
  }

}