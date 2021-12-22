import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_form_field_validation/repository/user_repository.dart';

import 'bloc/form_condition.dart';
import 'bloc/form_page_cubit.dart';
import 'bloc/form_page_state.dart';
import 'component/change_password_form.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        child: const TextFormFieldValidationApp()),
  );
}

class TextFormFieldValidationApp extends StatelessWidget {
  const TextFormFieldValidationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Validation Demo',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
            create: (context) => FormPageCubit(UserRepository()),
            child: const FieldValidatedFormPage(
                title: 'Applicative Validation Demo')));
  }
}

class FieldValidatedFormPage extends StatefulWidget {
  const FieldValidatedFormPage({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  State<FieldValidatedFormPage> createState() => _FieldValidatedFormPageState();
}

class _FieldValidatedFormPageState extends State<FieldValidatedFormPage> {
  final _formKey = GlobalKey<FormState>();

  void listener(
      BuildContext context,
      FormCondition<FormPageStateSubmissionFailure, FormPageStateSubmission>
          formCondition) {
    formCondition.outcome<void>(
        (failure) => failure.status<void>(
            () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(tr(failure.failureMessage)),
                backgroundColor: Colors.red.shade400)),
            () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(tr(failure.failureMessage)),
                backgroundColor: Colors.orange.shade400))),
        (submission) => submission.status<void>(
            () {},
            () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(tr("submission_success.msg")),
                backgroundColor: Colors.green.shade400))));
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FormPageCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Form(
            key: _formKey,
            child: BlocConsumer<FormPageCubit, FormPageState>(
              listener: (context, state) => listener(context, state),
              builder: (context, state) => state.outcome<Widget>(
                  (failure) => failure.status(
                      changePasswordForm(
                          context,
                          failure.username,
                          failure.password,
                          failure.newPassword1,
                          failure.newPassword2),
                      changePasswordForm(
                          context,
                          failure.username,
                          failure.password,
                          failure.newPassword1,
                          failure.newPassword2)),
                  (submission) => submission.status(
                      changePasswordForm(
                          context,
                          submission.username,
                          submission.password,
                          submission.newPassword1,
                          submission.newPassword2,
                          submission.formErrors),
                      changePasswordForm(
                          context,
                          submission.username,
                          submission.password,
                          submission.newPassword1,
                          submission.newPassword2))),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            cubit.submitForm();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Form submitted')),
            );
          }
        },
        tooltip: 'press to submit',
        child: const Text("Submit"),
      ),
    );
  }
}
