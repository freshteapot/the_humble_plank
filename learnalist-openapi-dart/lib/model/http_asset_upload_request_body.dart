part of openapi.api;

class HttpAssetUploadRequestBody {
  String sharedWith = null;
  //enum sharedWithEnum {  private,  public,  };{

  MultipartFile file = null;
  HttpAssetUploadRequestBody();

  @override
  String toString() {
    return 'HttpAssetUploadRequestBody[sharedWith=$sharedWith, file=$file, ]';
  }

  HttpAssetUploadRequestBody.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    sharedWith = json['shared_with'];
    file = (json['file'] == null)
        ? null
        : MultipartFile.fromString("file", json['file']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (sharedWith != null) json['shared_with'] = sharedWith;
    if (file != null) json['file'] = file;
    return json;
  }

  static List<HttpAssetUploadRequestBody> listFromJson(List<dynamic> json) {
    return json == null
        ? List<HttpAssetUploadRequestBody>()
        : json
            .map((value) => HttpAssetUploadRequestBody.fromJson(value))
            .toList();
  }

  static Map<String, HttpAssetUploadRequestBody> mapFromJson(
      Map<String, dynamic> json) {
    var map = Map<String, HttpAssetUploadRequestBody>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) =>
          map[key] = HttpAssetUploadRequestBody.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of HttpAssetUploadRequestBody-objects as value to a dart map
  static Map<String, List<HttpAssetUploadRequestBody>> mapListFromJson(
      Map<String, dynamic> json) {
    var map = Map<String, List<HttpAssetUploadRequestBody>>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) {
        map[key] = HttpAssetUploadRequestBody.listFromJson(value);
      });
    }
    return map;
  }
}
