/* Base Idea: scrap all permissions from the app store and write to file.
Since "All Permissions" (submitted app) is missing SMS and CALL_LOG permissions (see caveats in README),
we additionally scrap two apps that have the CALL_LOG and SMS permissions: 
https://play.google.com/store/apps/details?id=com.truecaller, and
https://play.google.com/store/apps/details?id=com.google.android.apps.messaging */


const gplay = require('google-play-scraper');

function addToSet(items) {
    items.forEach(item => {
        //console.log(item)
        permissionSet.add(item);
    })
}

let p0 = gplay.permissions({appId: "com.permissions.all_permissions", lang: "en"});
let p1 = gplay.permissions({appId: "com.truecaller", lang: "en"});
let p2 = gplay.permissions({appId: "com.google.android.apps.messaging", lang: "en"});

const permissionSet = new Set();  // To avoid repetitions

Promise.all([p0, p1, p2]).then(resultArray => {  
    resultArray.forEach(result => addToSet(result));
    permissionSet.forEach(item => console.log('"' + item.permission + '": '));
});