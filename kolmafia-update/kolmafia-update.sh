#!/bin/bash

kolmafia_url=https://ci.kolmafia.us/job/Kolmafia/

update_candidate=$(curl $kolmafia_url | grep -o 'lastSuccessfulBuild/artifact/dist/KoLmafia-[0-9]*.jar' | head -1)
current_client=$(find . -maxdepth 1 -iname "kolmafia*.jar" -printf '%p\n' | sort -nr | head -n 1)

update_version=$(echo $update_candidate | sed -e s/[^0-9]//g)
current_version=$(echo $current_client | sed -e s/[^0-9]//g)

echo "[KoLMafia Updater] Current version: $current_version, Available version: $update_version"

if [[ "$current_version" -lt "$update_version" ]]; then
        wget "$kolmafia_url$update_candidate"
fi
