part of openapi.api;

class RemindMedium {
  /// The underlying value of this enum member.
  final String value;

  const RemindMedium._internal(this.value);

  /// What medium do you want the reminder sent via
  static const RemindMedium push_ = const RemindMedium._internal("push");
  /// What medium do you want the reminder sent via
  static const RemindMedium email_ = const RemindMedium._internal("email");

  static RemindMedium fromJson(String value) {
    return new RemindMediumTypeTransformer().decode(value);
  }
  
  static List<RemindMedium> listFromJson(List<dynamic> json) {
    return json == null ? new List<RemindMedium>() : json.map((value) => RemindMedium.fromJson(value)).toList();
  }
}

class RemindMediumTypeTransformer {

  dynamic encode(RemindMedium data) {
    return data.value;
  }

  RemindMedium decode(dynamic data) {
    switch (data) {
      case "push": return RemindMedium.push_;
      case "email": return RemindMedium.email_;
      default: throw('Unknown enum value to decode: $data');
    }
  }
}

