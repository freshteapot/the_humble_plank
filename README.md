# The Humble Plank
- A small utility app with the focus around strengthening your core.
- Data is saved to [learnalist.net](https://learnalist.net/).

## Working theory
> A happy healthy body, will aid with learning.

## Features
- Record a plank
- History of your planks
- Create a challenge / group.
- Share the challenge with your friends.
- Record a plank for a challenge and notify others in the group.
- Able to change your backend (where you store the data)
- Api is based on openapi spec (TODO add link)

## Build ipa
- increment build or major version
- create ipa
```sh
flutter build ipa
```
- open ipa, validate and distribute
```sh
open  build/ios/archive/Humble\ Plank.xcarchive
```
- upload it
- Goto https://appstoreconnect.apple.com/login

## Development

### learnalist-openapi-dart
This comes from generating dart client library for [learnalist.net](https://github.com/freshteapot/learnalist-api).

#### To update
- Clone http://github.com/freshteapot/learnalist-api/
- Generate openapi for dart
```
make generate-openapi-dart
```
- Copy to this app
```
cp -r /tmp/openapi/dart/ learnalist-openapi-dart
```

- [Due to bug](https://github.com/OpenAPITools/openapi-generator/issues/7589), we need to replace in learnalist-openapi-dart/lib/model/http_asset_upload_request_body.dart

In   HttpAssetUploadRequestBody.fromJson
```
    file = (json['file'] == null)
        ? null
        : MultipartFile.fromString("file", json['file']);
```

## Getting secrets
```
mkdir -p ~/git/secrets/thehumbleplank/android/app
```

```
mkdir -p ~/git/secrets/thehumbleplank/android/app/google-services.json
cp ~/git/secrets/thehumbleplank/android/app/google-services.json android/app/google-services.json
```

```
cp ~/git/secrets/ios-thehumbleplank-GoogleService-Info.plist ios/Runner/GoogleService-Info.plist
```

### Sign the app for android
```
keytool -genkey -v -keystore ~/git/secrets/the_humble_plank_key.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias the_humble_plank_key
```

```
cp ~/git/secrets/android-key.properties android/key.properties
```

```
keytool -list -v \
-alias the_humble_plank_key -keystore ~/git/secrets/the_humble_plank_key.jks
```

### Create feature icon from play icon
```
convert assets/icon/android-play-icon.png -gravity center \
    -background white \
    -compress jpeg \
    -extent 1024x500 assets/icon/android-play-feature-graphic.png
```

### Update the icons
```
flutter pub run flutter_launcher_icons:main
```

### Deploy android
- Need to use x86_64 in your emulator (changeable after the fact)

```
ANDROID_HOME=/Users/tinkerbell/Library/Android/sdk \
bundletool build-apks \
--bundle=build/app/outputs/bundle/release/app-release.aab \
--output=/tmp/the-humble-app.apks \
--ks=~/git/secrets/the_humble_plank_key.jks \
--ks-key-alias=the_humble_plank_key \
--overwrite \
--device-spec=/tmp/device-spec.json
```

```
bundletool install-apks --apks=/tmp/the-humble-app.apks
```

### Register users
- Simple plank app

```sh
curl -XPOST 'http://127.0.0.1:1234/api/v1/user/register' -d'
{
    "username":"iamtest1",
    "password":"test123",
    "extra": {
        "display_name": "Chris",
        "created_via": "plank.app.v1"
    }
}
'

curl -XPOST 'http://127.0.0.1:1234/api/v1/user/register' -d'
{
    "username":"iamtest2",
    "password":"test123",
    "extra": {
        "display_name": "Tine",
        "created_via": "plank.app.v1"
    }
}
'

```

### Delete user
```sh
response=$(curl -s -XPOST 'http://127.0.0.1:1234/api/v1/user/login' -d'
{
    "username":"iamtest1",
    "password":"test123"
}
')
userUUID=$(echo $response | jq -r '.user_uuid')
token=$(echo $response | jq -r '.token')
curl -i -XDELETE -H"Authorization: Bearer ${token}" "http://localhost:1234/api/v1/user/${userUUID}"
```



#
> error: The sandbox is not in sync with the Podfile.lock. Run 'pod install' or update your CocoaPods installation.

```
cd ios
pod install
```




# Reference
- https://github.com/freshteapot/learnalist-api
- https://developers.google.com/android/guides/client-auth
- https://github.com/OpenAPITools/openapi-generator/issues/7589
- https://github.com/fluttercommunity/flutter_launcher_icons
