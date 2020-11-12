# The Humble Plank

```
_googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        print(_currentUser);
        _peek();
      }
    });
    _googleSignIn.signInSilently();



  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _peek() async {
    var a = await _currentUser.authentication;
    print("idToken: ${a.idToken}");
    print("accessToken: ${a.accessToken}");
    print("serverAuthCode: ${a.serverAuthCode}");
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();



```



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


