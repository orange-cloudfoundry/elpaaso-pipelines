#!/usr/bin/env bash

CW=$PWD

actual_version=$(curl -s http://www.mattermost.org/download/ | pup '.entry-content h2' | grep Mattermost | awk '{print $4}')
current_version=$(head -n 1 "$CW/mattermost-integrator-github/tag")
if [ "$actual_version" = "$current_version" ]; then
    echo "The version $actual_version already exists."
    exit 1
fi
semver=$(echo "$actual_version" | sed 's/v//g')
echo "$semver" | grep -Eq "^[0-9]{1,2}\.[0-9]{1,2}\.[0-9]{1,2}$"
if [ $? -ne 0 ]; then
    echo "Parsed version do not follow semantical versionning, check http://www.mattermost.org/download page and fix the parsing"
    exit 1
fi
echo "$semver" > "$CW/mattermost-integrator-github/tag_to_release"
echo "Mattermost $semver on Cloud Foundry" > "$CW/mattermost-integrator-github/name_of_release"
exit 0