import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_form_field_validation/repository/user_repository.dart';

import 'bloc/form_condition.dart';
import 'bloc/form_model.dart';
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

  // listener will deal with submission warnings and failures
  void listener(
      BuildContext context, FormCondition<FormPageState> formCondition) {
    formCondition.warned(
        (warnings) => warnings.map((warning) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
                content: Text(tr(warning.message.toString())),
                backgroundColor: Colors.orange.shade400))),
        () {});

    formCondition.failed(
        (failures) => failures.map((failure) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
                content: Text(tr(failure.message.toString())),
                backgroundColor: Colors.red.shade400))),
        () {});
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
            child: BlocConsumer<FormPageCubit, FormModel<FormPageState>>(
                listener: (context, state) => listener(context, state),
                builder: (context, state) => state.readied<Widget>(
                    (form) => changePasswordForm(context, form.username,
                        form.password, form.newPassword1, form.newPassword2),
                    (form, errors) => changePasswordForm(
                        context,
                        form.username,
                        form.password,
                        form.newPassword1,
                        form.newPassword2,
                        errors))),
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
