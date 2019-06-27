The purpose of this repository is to create a mapping between google play permission descriptions to android permission names. 

The mapping is found in `outputs/mapping.js`.

I'll submit the mapping to https://github.com/facundoolano/google-play-scraper, such that permission names will be available when scrapping.

## Why is this useful?
Currently, to get an app's permission names (as given by the android developers reference), one has to download the apk and parse the manifest. However, play store already gives apps' permissions but only the descriptions. Thus a scrapper (e.g. https://github.com/facundoolano/google-play-scraper) can get the description of the permissions, but not their name. Unfortunately, google play permission descriptions do not match android developers permission descriptions and thus, a mapping is required. Having this map integrated in a scraper allows to scrap the permissions with their respective names, therefore avoiding downloading the apk.

## Steps to rebuild the mapping

1. Scrap [android developers](https://developer.android.com/reference/android/Manifest.permission.html) to obtain all android default permission names. Done in `scrap_permission_names.sh`;

2. Get all permission descriptions. This requires the following sub-steps:

   2.1. Get permissions in "uses-permission" manifest format. Done in `get_manifest_uses-permissions.sh`;

   2.2. Write an android app requesting all permissions;

   2.3. Publish the app in google play. Not all permissions are allowed to be required without making use of the functionality, due to policy constraints. See the [Caveat](#Caveat) and [Workaround](#workaround) sections.

3. Scrap the submitted app in play store to extract all permission descriptions. Note: Already published apps will have permissions that are no longer in the android reference. Thus, the mapping will be imperfect even after crawling the published app;

4. Create the mapping. This process is highly manual as it is not obvious which descriptions belong to which permission. The [scraper](https://github.com/facundoolano/google-play-scraper) can be used to list permission short and long description.

### Progress Tracker

| Step | State | Outcome |
| ---- | ----- | ------- |
| 1.   | :ballot_box_with_check: | `scripts/scrap_permission_names.sh` |
| 2.1. | :ballot_box_with_check: | `scripts/get_manifest_uses-permissions.sh` |
| 2.2. | :ballot_box_with_check: | android app in `/android` |
| 2.3. | :ballot_box_with_check: | [google play link](https://play.google.com/store/apps/details?id=com.permissions.all_permissions) |
| 3.   | :ballot_box_with_check: | `scripts/play-scraper/scrap-permissions` |
| 4.   | :ballot_box_with_check: | `outputs/mapping.js` |


## Caveat

Apparently, requiring some permissions in the android manifest requires having a direct functionality to support them, or otherwise, the app is rejected on the play store. These permissions are related to SMS and CALL_LOG. According to my tests, these are the following permissions:

    <uses-permission android:name="android.permission.PROCESS_OUTGOING_CALLS"/>
    <uses-permission android:name="android.permission.READ_CALL_LOG"/>
    <uses-permission android:name="android.permission.READ_SMS"/>
    <uses-permission android:name="android.permission.RECEIVE_MMS"/>
    <uses-permission android:name="android.permission.RECEIVE_SMS"/>
    <uses-permission android:name="android.permission.RECEIVE_WAP_PUSH"/>
    <uses-permission android:name="android.permission.SEND_SMS"/>
    <uses-permission android:name="android.permission.WRITE_CALL_LOG"/>

#### Workaround: 

The `get_manifest_uses-permissions.sh` still prints these permissions but commented out. Thus, the published application does not have these permissions. Therefore, when scrapping the submitted app, it is required to additionally scrap apps that have these permissions and fuse the data (this data fusion is done in `scripts/play-scraper/scrap-permissions`).

Here's where we can get this data: (note that these apps may change their permissions in the future)

* For the **CALL_LOG** permissions: https://play.google.com/store/apps/details?id=com.truecaller. Manually confirmed that has in the manifest:

        <uses-permission android:name="android.permission.PROCESS_OUTGOING_CALLS"/>
        <uses-permission android:name="android.permission.READ_CALL_LOG"/>
        <uses-permission android:name="android.permission.WRITE_CALL_LOG"/>


* For the **SMS** permissions: https://play.google.com/store/apps/details?id=com.google.android.apps.messaging. Manually confirmed that has in the manifest:

        <uses-permission android:name="android.permission.READ_SMS" />
        <uses-permission android:name="android.permission.WRITE_SMS" /> <!-- Deprecated(?) -->  
        <uses-permission android:name="android.permission.RECEIVE_SMS" />
        <uses-permission android:name="android.permission.RECEIVE_MMS" />
        <uses-permission android:name="android.permission.SEND_SMS" />
        <uses-permission android:name="android.permission.RECEIVE_WAP_PUSH" />
