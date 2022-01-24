import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class FormPageState extends Equatable {
  final String username;
  final String password;
  final String newPassword1;
  final String newPassword2;

  const FormPageState(
      {required this.username,
      required this.password,
      required this.newPassword1,
      required this.newPassword2});

  FormPageState copyWith(
      {String? username,
      String? password,
      String? newPassword1,
      String? newPassword2}) {
    return FormPageState(
        username: username ?? this.username,
        password: password ?? this.password,
        newPassword1: newPassword1 ?? this.newPassword1,
        newPassword2: newPassword2 ?? this.newPassword2);
  }

  @override
  List<Object?> get props =>
      [username, password, newPassword1, newPassword2];
  
  @override
  bool? get stringify => false;
}