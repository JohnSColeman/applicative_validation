import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_form_field_validation/bloc/form_page_cubit.dart';
import 'package:text_form_field_validation/domain/validation/field_specs.dart';
import 'package:text_form_field_validation/localization/validated_localization.dart';

extension FindError on IList<ArgumentError> {
  /// returns the error of the given name for this list of errors
  ArgumentError? of(String name) =>
      find((error) => error.name == name).toNullable();
}

Widget Function() changePasswordForm(BuildContext context, String? username,
    String? password, String? password1, String? password2,
    [IList<ArgumentError>? errors]) {
  final cubit = context.read<FormPageCubit>();
  return () => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextFormField(
          initialValue: username,
          decoration: InputDecoration(
              labelText: 'Username', errorText: tre(errors?.of("username"))),
          inputFormatters: [LengthLimitingTextInputFormatter(15)],
          validator: (value) => trv(usernameValidator(value)),
          onSaved: (value) => cubit.changeUsername(value!)),
      TextFormField(
          initialValue: password,
          decoration: InputDecoration(
              labelText: 'Current Password',
              errorText: tre(errors?.of("password"))),
          inputFormatters: [LengthLimitingTextInputFormatter(12)],
          validator: (value) =>
              trvk("password.err", passwordValidator(value)),
          onSaved: (value) => cubit.changePassword(value!)),
      TextFormField(
          initialValue: password1,
          decoration: InputDecoration(
              labelText: 'New Password',
              errorText: tre(errors?.of("newPassword1"))),
          inputFormatters: [LengthLimitingTextInputFormatter(12)],
          validator: (value) =>
              trvk("password.err", newPassword1Validator(value)),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onSaved: (value) => cubit.changePassword1(value!)),
      TextFormField(
          initialValue: password2,
          decoration: InputDecoration(
              labelText: 'New Password',
              errorText: tre(errors?.of("newPassword2"))),
          inputFormatters: [LengthLimitingTextInputFormatter(12)],
          validator: (value) =>
              trvk("password.err", newPassword2Validator(value)),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onSaved: (value) => cubit.changePassword2(value!)),
    ],
  );
}
