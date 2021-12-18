import 'dart:math';

import 'package:dartz/dartz.dart';

class IoError implements Error {
  @override
  StackTrace? get stackTrace => throw UnimplementedError();
}

class EndpointWarning implements Error {
  @override
  StackTrace? get stackTrace => throw UnimplementedError();
}

class UserRepository {
  final users = {"johndoe01": "johndoe1984", "fredsmith01": "fredsmith1998"};

  ///  verify that the given credentials match in the repository
  Future<Either<IoError, Either<EndpointWarning, bool>>> verifyCredential(
      String username, String password) {
    return Future.delayed(const Duration(seconds: 2), () {
      if (Random().nextBool()) return left(IoError()); // simulate failure
      if (users.containsKey(username)) {
        return right(right(users[username] == password));
      }
      return right(left(EndpointWarning()));
    });
  }
}
