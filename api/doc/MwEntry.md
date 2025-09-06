# mindwell_api.model.MwEntry

## Load the model package
```dart
import 'package:mindwell_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** |  | [optional] 
**author** | [**MwUser**](MwUser.md) |  | [optional] 
**user** | [**MwUser**](MwUser.md) |  | [optional] 
**createdAt** | **double** |  | [optional] 
**rating** | [**MwRating**](MwRating.md) |  | [optional] 
**title** | **String** |  | [optional] 
**cutTitle** | **String** |  | [optional] 
**content** | **String** |  | [optional] 
**cutContent** | **String** |  | [optional] 
**editContent** | **String** |  | [optional] 
**hasCut** | **bool** |  | [optional] 
**images** | [**BuiltList&lt;MwImage&gt;**](MwImage.md) |  | [optional] 
**insertedImages** | [**BuiltList&lt;MwImage&gt;**](MwImage.md) |  | [optional] 
**tags** | **BuiltList&lt;String&gt;** |  | [optional] 
**wordCount** | **int** |  | [optional] 
**privacy** | **String** |  | [optional] 
**visibleFor** | [**BuiltList&lt;MwUser&gt;**](MwUser.md) |  | [optional] 
**isCommentable** | **bool** |  | [optional] 
**inLive** | **bool** |  | [optional] 
**isAnonymous** | **bool** |  | [optional] 
**isShared** | **bool** |  | [optional] 
**isPinned** | **bool** |  | [optional] 
**commentCount** | **int** |  | [optional] 
**favoriteCount** | **int** |  | [optional] 
**isFavorited** | **bool** |  | [optional] 
**isWatching** | **bool** |  | [optional] 
**comments** | [**MwCommentList**](MwCommentList.md) |  | [optional] 
**rights** | [**MwEntryRights**](MwEntryRights.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


