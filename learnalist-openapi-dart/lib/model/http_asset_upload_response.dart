part of openapi.api;

class HttpAssetUploadResponse {
  
  String href = null;
  
  String uuid = null;
  
  String ext = null;
  HttpAssetUploadResponse();

  @override
  String toString() {
    return 'HttpAssetUploadResponse[href=$href, uuid=$uuid, ext=$ext, ]';
  }

  HttpAssetUploadResponse.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    href = json['href'];
    uuid = json['uuid'];
    ext = json['ext'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (href != null)
      json['href'] = href;
    if (uuid != null)
      json['uuid'] = uuid;
    if (ext != null)
      json['ext'] = ext;
    return json;
  }

  static List<HttpAssetUploadResponse> listFromJson(List<dynamic> json) {
    return json == null ? List<HttpAssetUploadResponse>() : json.map((value) => HttpAssetUploadResponse.fromJson(value)).toList();
  }

  static Map<String, HttpAssetUploadResponse> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, HttpAssetUploadResponse>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = HttpAssetUploadResponse.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of HttpAssetUploadResponse-objects as value to a dart map
  static Map<String, List<HttpAssetUploadResponse>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<HttpAssetUploadResponse>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = HttpAssetUploadResponse.listFromJson(value);
       });
     }
     return map;
  }
}

