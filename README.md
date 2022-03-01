# Applicative Validation
A client and server side library for composable declarative validation using applicative with [Dartz](https://pub.dev/packages/dartz).

## Usage
A Validated is a Dartz Either that returns an ArgumentError for a failed validation
or an optional type of A? for a success.
```dart
/// Alias for Either with left type ArgumentError right validate value type A
typedef Validated<A> = Either<ArgumentError, A?>;

/// Alias for function that returns a Validation given a NameValue
typedef Validation<A> = Validated<A> Function(NameValue<A>);
```
A Validation is a function encapsulating some imperative logic applied to the given NameValue:
```dart
Validation<String> notEmpty() =>
    (NameValue<String> nameValue) => nameValue.value.trim().isNotEmpty
        ? right(nameValue.value)
        : left(ArgumentError.value(
            nameValue.value,
            nameValue.name,
            ErrorArgumentsBinding("empty.err", {}),
          ));
```
Validations can be combined using a default applicative operator `&` to aggregate multiple error messages
(or message keys) into an ArgumentError with multiple failure messages or the success type.
```dart
/// Extension methods to give Validated operators
extension ValidatedSemigroupApplicativeOperator<A> on Validated<A> {
  ///  applicative operator - aggregates ArgumentErrors using default semigroup
  Validated<A?> operator &(Validated<A?> other) =>
      aps(other.map((a) => id), argumentErrorSi);

  ///  flatmap operator - terminate validation on error or continue with other
  Validated<A?> operator +(Validated<A?> other) => flatMap((_) => this & other);
}
```
The `+` operator can be used like an or `||` operator to group associated validations:


### Add dependency

### Validators
Create validators for fields by providing a list of the required validators. These validators
can be packaged into a library for reuse.
```dart
final passwordValidator = Validator<String>(
    name: "password",
    validation: [minLength(8), maxLength(12), noWhiteSpace(), nonRepeating()]);
```
Use validator for a form field:
```dart
      TextFormField(
          initialValue: password,
          decoration: InputDecoration(
              labelText: 'Current Password',
              errorText: tre(errors?.of("password"))),
          inputFormatters: [LengthLimitingTextInputFormatter(12)],
          validator: (value) => trvk("password.err", passwordValidator(value)),
          onSaved: (value) => cubit.changePassword(value!)),
```
Implement a Cubit of FormModel of the type of your state class and implement to FormSubmission
to handle success or failure of the form submission:
```dart
class FormPageCubit extends Cubit<FormModel<FormPageState>>
    with FormSubmission<ChangePasswordRequest> {

  void changePassword(String password) => state.readied(
    (form) => emit(formModel(form.copyWith(password: password))),
    (form, errors) =>
      emit(formModel(initState.copyWith(password: password))));
  
    }
    
    
```
