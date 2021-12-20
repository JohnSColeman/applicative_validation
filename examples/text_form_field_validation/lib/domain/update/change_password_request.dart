class ChangePasswordRequest {
  final String username;
  final String password;
  final String newPassword1;
  final String newPassword2;

//<editor-fold desc="Data Methods">

  const ChangePasswordRequest({
    required this.username,
    required this.password,
    required this.newPassword1,
    required this.newPassword2,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChangePasswordRequest &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          password == other.password &&
          newPassword1 == other.newPassword1 &&
          newPassword2 == other.newPassword2);

  @override
  int get hashCode =>
      username.hashCode ^
      password.hashCode ^
      newPassword1.hashCode ^
      newPassword2.hashCode;

  @override
  String toString() {
    return 'ChangePasswordRequest{' +
        ' username: $username,' +
        ' password: $password,' +
        ' newPassword1: $newPassword1,' +
        ' newPassword2: $newPassword2,' +
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'newPassword1': newPassword1,
      'newPassword2': newPassword2,
    };
  }

  factory ChangePasswordRequest.fromMap(Map<String, dynamic> map) {
    return ChangePasswordRequest(
      username: map['username'] as String,
      password: map['password'] as String,
      newPassword1: map['newPassword1'] as String,
      newPassword2: map['newPassword2'] as String,
    );
  }

//</editor-fold>
}
