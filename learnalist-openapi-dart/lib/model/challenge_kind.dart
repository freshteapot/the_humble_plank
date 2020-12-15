part of openapi.api;

class ChallengeKind {
  /// The underlying value of this enum member.
  final String value;

  const ChallengeKind._internal(this.value);

  static const ChallengeKind plankGroup_ = const ChallengeKind._internal("plank-group");

  static ChallengeKind fromJson(String value) {
    return new ChallengeKindTypeTransformer().decode(value);
  }
  
  static List<ChallengeKind> listFromJson(List<dynamic> json) {
    return json == null ? new List<ChallengeKind>() : json.map((value) => ChallengeKind.fromJson(value)).toList();
  }
}

class ChallengeKindTypeTransformer {

  dynamic encode(ChallengeKind data) {
    return data.value;
  }

  ChallengeKind decode(dynamic data) {
    switch (data) {
      case "plank-group": return ChallengeKind.plankGroup_;
      default: throw('Unknown enum value to decode: $data');
    }
  }
}

