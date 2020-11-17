import 'package:openapi/api.dart';
import 'package:test/test.dart';


/// tests for AssetApi
void main() {
  var instance = AssetApi();

  group('tests for AssetApi', () {
    // Upload asset and link it to the user logged in
    //
    //Future<HttpAssetUploadResponse> addUserAsset(MultipartFile file, { String sharedWith }) async 
    test('test addUserAsset', () async {
      // TODO
    });

    // Deletes a single asset based on the UUID
    //
    //Future deleteAsset(String uuid) async 
    test('test deleteAsset', () async {
      // TODO
    });

    //Future getAsset(String uuid) async 
    test('test getAsset', () async {
      // TODO
    });

    // Set asset for public or private access
    //
    //Future<HttpResponseMessage> shareAsset(HttpAssetShareRequestBody httpAssetShareRequestBody) async 
    test('test shareAsset', () async {
      // TODO
    });

  });
}
