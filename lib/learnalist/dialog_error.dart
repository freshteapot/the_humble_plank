import 'package:meta/meta.dart';

class DialogError {
  final int code;
  final String message;

  DialogError({
    @required this.code,
    @required this.message,
  });
}
