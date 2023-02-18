class Failure {
  String message;
  Failure({
    required this.message,
  });
}

class GenericFailure extends Failure {
  GenericFailure({super.message = 'Oops! Something went wrong...'});
}

class LogoutFailure extends Failure {
  LogoutFailure({super.message = 'Cannot sign out the User. Please, retry.'});
}

class FirebaseFailure extends Failure {
  final String code;
  final String plugin;

  FirebaseFailure({
    this.code = '',
    this.plugin = '',
    super.message = '',
  });

  @override
  String toString() => 'FirebaseFailure(code: $code, plugin: $plugin)';
}
