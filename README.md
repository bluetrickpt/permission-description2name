The purpose of this repository is to create a mapping between google play permission descriptions to android permission names. 

## Why is this useful?
Currently, to get an app's permissions, one has to download the apk and parse the manifest. However, play store already gives apps' permissions but only the descriptions. Thus a scrapper (e.g. https://github.com/facundoolano/google-play-scraper) can get the description of the permissions, but not their name. Unfortunately, google play permission descriptions do not match android developers permission descriptions and thus, a mapping is required. Having this map integrated in a scraper allows to scrap the permissions with their respective names.

## TODO List

1. Scrap [android developers](https://developer.android.com/reference/android/Manifest.permission.html) to obtain all android default permission names. Done in `scrap_permission_names.sh`;

2. Get all permission descriptions. This requires the following sub-steps:

   2.1. Get permissions in "uses-permission" manifest format. Done in `get_manifest_uses-permissions.sh`;

   2.2. Write an android app requesting all permissions;

   2.3. Publish the app in google play.

3. Scrap the submitted app in play store to extract all permission descriptions;

4. Create the mapping. The mapping should be in json to be easily used by any scraper.

When this todo list is complete, creating a mapping only requires step 1, 3 and 4. However, if google adds/updates permissions, step 2 must also be repeated.


## Caveats

Apparently, requiring some permissions in the android manifest requires having a direct functionality to support them. These permissions are related to SMS and CALL_LOG. According to my tests, these are the following permissions:

    <uses-permission android:name="android.permission.PROCESS_OUTGOING_CALLS"/>
    <uses-permission android:name="android.permission.READ_CALL_LOG"/>
    <uses-permission android:name="android.permission.READ_SMS"/>
    <uses-permission android:name="android.permission.RECEIVE_MMS"/>
    <uses-permission android:name="android.permission.RECEIVE_SMS"/>
    <uses-permission android:name="android.permission.RECEIVE_WAP_PUSH"/>
    <uses-permission android:name="android.permission.SEND_SMS"/>
    <uses-permission android:name="android.permission.WRITE_CALL_LOG"/>

### Workaround: 

The `get_manifest_uses-permissions.sh` still prints these permissions but commented out. Thus, the published application does not have these permissions. Therefore, when scrapping the submitted app, it is required to additionally scrap apps that have these permissions and fuse the data.

Here's where we can get this data:
* For the call_log permissions: https://play.google.com/store/apps/details?id=v.d.d.answercall or https://play.google.com/store/apps/details?id=com.truecaller

* For the message permissions: https://play.google.com/store/apps/details?id=com.google.android.apps.messaging