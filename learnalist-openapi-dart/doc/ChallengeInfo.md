# openapi.model.ChallengeInfo

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**kind** | **String** | Look at ChallengeKind for supported kinds | [default to &quot;&quot;]
**description** | **String** |  | [default to &quot;&quot;]
**created** | [**DateTime**](DateTime.md) | Set to UTC | [optional] [default to null]
**createdBy** | **String** | User who created the challenge | [default to null]
**uuid** | **String** |  | [default to null]
**users** | [**List&lt;ChallengeInfoAllOfUsers&gt;**](ChallengeInfoAllOfUsers.md) | List of users | [default to []]
**records** | [**List&lt;ChallengePlankRecord&gt;**](ChallengePlankRecord.md) | List of records, specific to the kind | [default to []]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


