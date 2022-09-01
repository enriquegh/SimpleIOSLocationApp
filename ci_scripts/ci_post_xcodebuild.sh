#!/bin/sh

#  ci_post_xcodebuild.sh
#  SimpleLocationApp
#
#  Created by Enrique Gonzalez on 8/31/22.
#  Copyright © 2022 Enrique Gonzalez. All rights reserved.

echo "Hello World!"
echo $CI_WORKFLOW
echo $CI_ARCHIVE_PATH
if [ "$CI_WORKFLOW" = 'Saucelabs Test' ];
then

    if [ $CI_XCODEBUILD_ACTION = 'archive' ]
    then
        echo "Uploading to SauceLabs"
        PAYLOAD=$(printf "@\"%s\"" "$CI_DEVELOPMENT_SIGNED_APP_PATH")

        # Upload ipa to Saucelabs
        curl --tlsv1.2 --tls-max 1.2 -v -u "$SAUCE_USERNAME:$SAUCE_ACCESS_KEY" --location \
                  --request POST 'https://api.us-west-1.saucelabs.com/v1/storage/upload' \
                  --form "payload=$PAYLOAD" \
                  --form 'name="Health Connect.ipa"'

        echo "-----------------------------------------------------------------------------------------------------------------"
        
        echo "Upload to EMEA"
        # Upload ipa to Saucelabs
        curl --tlsv1.2 --tls-max 1.2 -v -u "$SAUCE_USERNAME:$SAUCE_ACCESS_KEY" --location \
                  --request POST 'https://api.eu-central-1.saucelabs.com/v1/storage/upload' \
                  --form "payload=$PAYLOAD" \
                  --form 'name="SimpleLocationApp.ipa"'

        echo "-----------------------------------------------------------------------------------------------------------------"


        echo "Curl Concurrency"
        curl -u "$SAUCE_USERNAME:$SAUCE_ACCESS_KEY" --location \
            --request GET "https://api.us-west-1.saucelabs.com/rest/v1.2/users/$SAUCE_USERNAME/concurrency" \
            --header 'Content-Type: application/json'


        echo "-----------------------------------------------------------------------------------------------------------------"

        echo "Open SSL Version"
        openssl version

        echo "-----------------------------------------------------------------------------------------------------------------"
        echo "Open SSL Info"
        openssl s_client -servername api.us-west-1.saucelabs.com -connect api.us-west-1.saucelabs.com:443 < /dev/null 2>/dev/null

        echo "-----------------------------------------------------------------------------------------------------------------"
        echo "Saucelabs Website"
        curl -vvvv https://saucelabs.com/rest/v1/info/counter

        echo "-----------------------------------------------------------------------------------------------------------------"
        echo "US West"
        curl -vvvv https://api.us-west-1.saucelabs.com/rest/v1/info/counter
    fi
fi
