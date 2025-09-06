#!/bin/bash

SPEC_FILE=https://mindwell.win/help/api/swagger.yaml
GEN_PATH=api

rm -rf $GEN_PATH

openapi-generator-cli generate \
    -g dart-dio \
    -i $SPEC_FILE \
    -o $GEN_PATH \
    --model-name-prefix Mw \
    --additional-properties=pubName=mindwell_api

sed -i "16i import 'package:mindwell_api/src/model/mw_friend.dart';" \
    $GEN_PATH/lib/src/model/mw_auth_profile.dart
sed -i "s/MwProfileGenderEnum/MwFriendGenderEnum/g; s/MwProfilePrivacyEnum/MwFriendPrivacyEnum/g; s/MwProfileChatPrivacyEnum/MwFriendChatPrivacyEnum/g" \
    $GEN_PATH/lib/src/model/mw_auth_profile.dart

cd $GEN_PATH

dart pub add dev:unused_import_remover
dart pub run unused_import_remover ./lib/

dart pub get
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
