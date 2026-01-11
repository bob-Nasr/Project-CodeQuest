class User {
  int userId;
  String username;
  String password;
  String name;
  String phoneNumber;

  User({
    required this.userId,
    required this.username,
    required this.password,
    required this.name,
    required this.phoneNumber,
  });

  // Factory to parse from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      username: json['username'],
      password: json['password'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'password': password,
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }
}
