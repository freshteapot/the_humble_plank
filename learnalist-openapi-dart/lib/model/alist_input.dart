part of openapi.api;

class AlistInput {
  
  AlistInfo info = null;
  
  AnyType data = null;
  AlistInput();

  @override
  String toString() {
    return 'AlistInput[info=$info, data=$data, ]';
  }

  AlistInput.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    info = (json['info'] == null) ?
      null :
      AlistInfo.fromJson(json['info']);
    data = (json['data'] == null) ?
      null :
      AnyType.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (info != null)
      json['info'] = info;
    if (data != null)
      json['data'] = data;
    return json;
  }

  static List<AlistInput> listFromJson(List<dynamic> json) {
    return json == null ? List<AlistInput>() : json.map((value) => AlistInput.fromJson(value)).toList();
  }

  static Map<String, AlistInput> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, AlistInput>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = AlistInput.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of AlistInput-objects as value to a dart map
  static Map<String, List<AlistInput>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<AlistInput>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = AlistInput.listFromJson(value);
       });
     }
     return map;
  }
}

