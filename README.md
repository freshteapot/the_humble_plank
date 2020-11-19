# The Humble Plank

# TODO
- [ ] When building the service to process the events, cheat on startup by querying the api for all the challenge relationships.

## learnalist-openapi-dart
This comes from generating dart client library for [learnalist.net](https://github.com/freshteapot/learnalist-api).

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

# Development

## Register users
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

## Delete user
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




https://developers.google.com/android/guides/client-auth
