import 'package:equatable/equatable.dart';

class Failure {
  String message;
  Failure({
    required this.message,
  });
}

class FirebaseFailure extends Failure with EquatableMixin {
  final String code;
  final String plugin;

  FirebaseFailure({
    this.code = '',
    this.plugin = '',
    super.message = '',
  });

  @override
  String toString() => 'FirebaseFailure(code: $code, plugin: $plugin)';

  @override
  List<Object> get props => [code, plugin];
}
