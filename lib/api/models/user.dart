class User {
  final String email;
  final bool emailVerified;

  User.fromJson(Map<String, dynamic> data)
      : email = data["email"] as String,
        emailVerified = data["email_verified"] as bool;
}
