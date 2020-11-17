part of openapi.api;

class QueryParam {
  String name;
  String value;

  QueryParam(this.name, this.value);
}

class ApiClient {

  String basePath;
  var client = Client();

  Map<String, String> _defaultHeaderMap = {};
  Map<String, Authentication> _authentications = {};

  final _regList = RegExp(r'^List<(.*)>$');
  final _regMap = RegExp(r'^Map<String,(.*)>$');

  ApiClient({this.basePath = "https://learnalist.net/api/v1"}) {
    // Setup authentications (key: authentication name, value: authentication).
    _authentications['basicAuth'] = HttpBasicAuth();
    _authentications['bearerAuth'] = HttpBearerAuth();
  }

  void addDefaultHeader(String key, String value) {
     _defaultHeaderMap[key] = value;
  }

  dynamic _deserialize(dynamic value, String targetType) {
    try {
      switch (targetType) {
        case 'String':
          return '$value';
        case 'int':
          return value is int ? value : int.parse('$value');
        case 'bool':
          return value is bool ? value : '$value'.toLowerCase() == 'true';
        case 'double':
          return value is double ? value : double.parse('$value');
        case 'Alist':
          return Alist.fromJson(value);
        case 'AlistAllOf':
          return AlistAllOf.fromJson(value);
        case 'AlistDataV1':
          return AlistDataV1.fromJson(value);
        case 'AlistDataV2':
          return AlistDataV2.fromJson(value);
        case 'AlistFrom':
          return AlistFrom.fromJson(value);
        case 'AlistInfo':
          return AlistInfo.fromJson(value);
        case 'AlistInput':
          return AlistInput.fromJson(value);
        case 'AlistInteract':
          return AlistInteract.fromJson(value);
        case 'AlistItemV2':
          return AlistItemV2.fromJson(value);
        case 'AnyType':
          return AnyType.fromJson(value);
        case 'ChallengeInfo':
          return ChallengeInfo.fromJson(value);
        case 'ChallengeInfoAllOf':
          return ChallengeInfoAllOf.fromJson(value);
        case 'ChallengeInfoAllOfUsers':
          return ChallengeInfoAllOfUsers.fromJson(value);
        case 'ChallengeInput':
          return ChallengeInput.fromJson(value);
        case 'ChallengePlankRecord':
          return ChallengePlankRecord.fromJson(value);
        case 'ChallengePlankRecordAllOf':
          return ChallengePlankRecordAllOf.fromJson(value);
        case 'ChallengeShortInfo':
          return ChallengeShortInfo.fromJson(value);
        case 'ChallengeShortInfoAllOf':
          return ChallengeShortInfoAllOf.fromJson(value);
        case 'HttpAssetShareRequestBody':
          return HttpAssetShareRequestBody.fromJson(value);
        case 'HttpAssetUploadRequestBody':
          return HttpAssetUploadRequestBody.fromJson(value);
        case 'HttpAssetUploadResponse':
          return HttpAssetUploadResponse.fromJson(value);
        case 'HttpResponseMessage':
          return HttpResponseMessage.fromJson(value);
        case 'HttpUserInfoInput':
          return HttpUserInfoInput.fromJson(value);
        case 'HttpUserLoginIDPInput':
          return HttpUserLoginIDPInput.fromJson(value);
        case 'HttpUserLoginRequest':
          return HttpUserLoginRequest.fromJson(value);
        case 'HttpUserLoginResponse':
          return HttpUserLoginResponse.fromJson(value);
        case 'HttpUserRegisterInput':
          return HttpUserRegisterInput.fromJson(value);
        case 'HttpUserRegisterResponse':
          return HttpUserRegisterResponse.fromJson(value);
        case 'Kind':
          return Kind.fromJson(value);
        case 'Plank':
          return Plank.fromJson(value);
        case 'SpacedRepetitionBase':
          return SpacedRepetitionBase.fromJson(value);
        case 'SpacedRepetitionBaseNew':
          return SpacedRepetitionBaseNew.fromJson(value);
        case 'SpacedRepetitionBaseSettings':
          return SpacedRepetitionBaseSettings.fromJson(value);
        case 'SpacedRepetitionBaseSettingsShow':
          return SpacedRepetitionBaseSettingsShow.fromJson(value);
        case 'SpacedRepetitionDataV2':
          return SpacedRepetitionDataV2.fromJson(value);
        case 'SpacedRepetitionEntryViewed':
          return SpacedRepetitionEntryViewed.fromJson(value);
        case 'SpacedRepetitionSettingsV2':
          return SpacedRepetitionSettingsV2.fromJson(value);
        case 'SpacedRepetitionV1':
          return SpacedRepetitionV1.fromJson(value);
        case 'SpacedRepetitionV1New':
          return SpacedRepetitionV1New.fromJson(value);
        case 'SpacedRepetitionV1NewAllOf':
          return SpacedRepetitionV1NewAllOf.fromJson(value);
        case 'SpacedRepetitionV2':
          return SpacedRepetitionV2.fromJson(value);
        case 'SpacedRepetitionV2New':
          return SpacedRepetitionV2New.fromJson(value);
        case 'SpacedRepetitionV2NewAllOf':
          return SpacedRepetitionV2NewAllOf.fromJson(value);
        case 'Version':
          return Version.fromJson(value);
        default:
          {
            Match match;
            if (value is List &&
                (match = _regList.firstMatch(targetType)) != null) {
              var newTargetType = match[1];
              return value.map((v) => _deserialize(v, newTargetType)).toList();
            } else if (value is Map &&
                (match = _regMap.firstMatch(targetType)) != null) {
              var newTargetType = match[1];
              return Map.fromIterables(value.keys,
                  value.values.map((v) => _deserialize(v, newTargetType)));
            }
          }
      }
    } on Exception catch (e, stack) {
      throw ApiException.withInner(500, 'Exception during deserialization.', e, stack);
    }
    throw ApiException(500, 'Could not find a suitable class for deserialization');
  }

  dynamic deserialize(String json, String targetType) {
    // Remove all spaces.  Necessary for reg expressions as well.
    targetType = targetType.replaceAll(' ', '');

    if (targetType == 'String') return json;

    var decodedJson = jsonDecode(json);
    return _deserialize(decodedJson, targetType);
  }

  String serialize(Object obj) {
    String serialized = '';
    if (obj == null) {
      serialized = '';
    } else {
      serialized = json.encode(obj);
    }
    return serialized;
  }

  // We don't use a Map<String, String> for queryParams.
  // If collectionFormat is 'multi' a key might appear multiple times.
  Future<Response> invokeAPI(String path,
                             String method,
                             Iterable<QueryParam> queryParams,
                             Object body,
                             Map<String, String> headerParams,
                             Map<String, String> formParams,
                             String nullableContentType,
                             List<String> authNames) async {

    _updateParamsForAuth(authNames, queryParams, headerParams);

    var ps = queryParams
      .where((p) => p.value != null)
      .map((p) => '${p.name}=${Uri.encodeQueryComponent(p.value)}');

    String queryString = ps.isNotEmpty ?
                         '?' + ps.join('&') :
                         '';

    String url = basePath + path + queryString;

    headerParams.addAll(_defaultHeaderMap);
    if (nullableContentType != null) {
      final contentType = nullableContentType;
      headerParams['Content-Type'] = contentType;
    }

    if(body is MultipartRequest) {
      var request = MultipartRequest(method, Uri.parse(url));
      request.fields.addAll(body.fields);
      request.files.addAll(body.files);
      request.headers.addAll(body.headers);
      request.headers.addAll(headerParams);
      var response = await client.send(request);
      return Response.fromStream(response);
    } else {
      var msgBody = nullableContentType == "application/x-www-form-urlencoded" ? formParams : serialize(body);
      final nullableHeaderParams = (headerParams.isEmpty)? null: headerParams;
      switch(method) {
        case "POST":
          return client.post(url, headers: nullableHeaderParams, body: msgBody);
        case "PUT":
          return client.put(url, headers: nullableHeaderParams, body: msgBody);
        case "DELETE":
          return client.delete(url, headers: nullableHeaderParams);
        case "PATCH":
          return client.patch(url, headers: nullableHeaderParams, body: msgBody);
        case "HEAD":
          return client.head(url, headers: nullableHeaderParams);
        default:
          return client.get(url, headers: nullableHeaderParams);
      }
    }
  }

  /// Update query and header parameters based on authentication settings.
  /// @param authNames The authentications to apply
  void _updateParamsForAuth(List<String> authNames, List<QueryParam> queryParams, Map<String, String> headerParams) {
    authNames.forEach((authName) {
      Authentication auth = _authentications[authName];
      if (auth == null) throw ArgumentError("Authentication undefined: " + authName);
      auth.applyToParams(queryParams, headerParams);
    });
  }

  T getAuthentication<T extends Authentication>(String name) {
    var authentication = _authentications[name];

    return authentication is T ? authentication : null;
  }
}
