class UserModel {
  String username;
  String email;
  int age;
  String gender;

  UserModel({
    required this.username,
    required this.email,
    required this.age,
    required this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      email: json['email'],
      age: json['age'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'age': age,
      'gender': gender,
    };
  }
}
