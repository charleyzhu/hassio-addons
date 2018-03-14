#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Node-Red
# Generates the Node-Red configuration file
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

CONFIG_PATH=/data/options.json
SETTINGS_JS=/share/node-red/settings.js

SSL=$(jq --raw-output ".ssl" $CONFIG_PATH)
KEYFILE=$(jq --raw-output ".keyfile" $CONFIG_PATH)
CERTFILE=$(jq --raw-output ".certfile" $CONFIG_PATH)
USER_COUNT=$(jq --raw-output ".users | length" $CONFIG_PATH)
HTTP_NODE_USER_COUNT=$(jq --raw-output ".http_node_user | length" $CONFIG_PATH)
PROJECTS=$(jq --raw-output ".projects" $CONFIG_PATH)

# Create /share/node-red folder
if [ ! -d /share/node-red ]; then
  echo "[INFO] Creating /share/node-red folder"
  mkdir -p /share/node-red
fi

# Migrate existing config files to handle upgrades from previous version
if [ -e /data/settings.js ] && [ ! -e $SETTINGS_JS ]; then
  echo "[INFO] Migrating existing config from /data to /share/node-red"
  mv -f /data/* /share/node-red/
  mv -f /data/.* /share/node-red/
  mv -f /share/node-red/options.json $CONFIG_PATH
fi

# Create default config if none exists
if [ ! -e $SETTINGS_JS ]; then
  echo "[INFO] Creating default settings"
  cp /root/settings.js $SETTINGS_JS
fi

# Add SSL configs
if [ "$SSL" == "true" ]; then
  echo "[INFO] Enabling SSL"
  sed -i 's/.*var fs = require("fs")/var fs = require("fs")/g' $SETTINGS_JS
  sed -i '/https: {/,/}/ s/\/\///' $SETTINGS_JS
  sed -i "s/.*key: fs.readFileSync('.*'),/        key: fs.readFileSync(\'\/ssl\/$KEYFILE\'),/g" $SETTINGS_JS
  sed -i "s/.*cert: fs.readFileSync('.*')/        cert: fs.readFileSync(\'\/ssl\/$CERTFILE\')/g" $SETTINGS_JS
else
  echo "[INFO] Disabling SSL"
  sed -i 's/.*var fs = require("fs")/\/\/var fs = require("fs")/g' $SETTINGS_JS
  sed -i '/^[ ]*https: {/,/}/ s/^[ ]*/    \/\//' $SETTINGS_JS
  sed -i "s/.*key: fs.readFileSync/    \/\/    key: fs.readFileSync/g" $SETTINGS_JS
  sed -i "s/.*cert: fs.readFileSync/    \/\/    cert: fs.readFileSync/g" $SETTINGS_JS
fi

# IDE Authentication
if [ "$USER_COUNT" == "0" ]; then
  echo "[INFO] Disabling IDE Authentication"
  sed -i '/^[ ]*adminAuth: {/,/},/ s/^[ ]*/    \/\//' $SETTINGS_JS
else
  echo "[INFO] Updating IDE Users"
  sed '/adminAuth:/Q' $SETTINGS_JS > $SETTINGS_JS.new
  echo "    adminAuth: {" >> $SETTINGS_JS.new
  echo "       type: \"credentials\"," >> $SETTINGS_JS.new
  echo "       users: [" >> $SETTINGS_JS.new

  for (( i=0; i < "$USER_COUNT"; i++ )); do
    USERNAME=$(jq --raw-output ".users[$i].username" $CONFIG_PATH)
    PASSWORD=$(jq --raw-output ".users[$i].password" $CONFIG_PATH)
    HASH=$(echo $PASSWORD | node-red-admin hash-pw | cut -d " " -f 2)
    PERMISSIONS=$(jq --raw-output ".users[$i].permissions" $CONFIG_PATH)
    if [ "$i" != "0" ]; then
      echo "                ," >> $SETTINGS_JS.new
    fi
    echo "[INFO] Adding IDE User $USERNAME"
    echo "                {" >> $SETTINGS_JS.new
    echo "                  username: \"$USERNAME\"," >> $SETTINGS_JS.new
    echo "                  password: \"$HASH\"," >> $SETTINGS_JS.new
    echo "                  permissions: \"$PERMISSIONS\"" >> $SETTINGS_JS.new
    echo "                }" >> $SETTINGS_JS.new
  done

  echo "       ]" >> $SETTINGS_JS.new
  echo "    }," >> $SETTINGS_JS.new
  echo >> $SETTINGS_JS.new

  sed -n -e '/To password protect the node-defined HTTP endpoints/,$p' $SETTINGS_JS >> $SETTINGS_JS.new

  mv -f $SETTINGS_JS $SETTINGS_JS.old
  mv -f $SETTINGS_JS.new $SETTINGS_JS
fi

# HTTP Node User
if [ "$HTTP_NODE_USER_COUNT" == "0" ]; then
  echo "[INFO] Disabling HTTP Node Authentication"
  sed -i '/^[ ]*httpNodeAuth: {/,/},/ s/^[ ]*/    \/\//' $SETTINGS_JS
else
  echo "[INFO] Updating HTTP Node User"
  USERNAME=$(jq --raw-output ".http_node_user[0].username" $CONFIG_PATH)
  PASSWORD=$(jq --raw-output ".http_node_user[0].password" $CONFIG_PATH)
  HASH=$(echo $PASSWORD | node-red-admin hash-pw | cut -d " " -f 2)
  echo "[INFO] Adding HTTP Node User $USERNAME"
  sed '/httpNodeAuth:/Q' $SETTINGS_JS > $SETTINGS_JS.new
  echo "    httpNodeAuth: {user:\"$USERNAME\",pass:\"$HASH\"}," >> $SETTINGS_JS.new
  sed -n -e '/httpStaticAuth/,$p' $SETTINGS_JS >> $SETTINGS_JS.new

  mv -f $SETTINGS_JS $SETTINGS_JS.old
  mv -f $SETTINGS_JS.new $SETTINGS_JS
fi

# Add Projects Config
if [ "$PROJECTS" == "true" ]; then
  echo "[INFO] Enabling Projects"
  sed '/^module.exports = {/q' $SETTINGS_JS > $SETTINGS_JS.new
  echo "    editorTheme: {" >> $SETTINGS_JS.new
  echo "        projects: {" >> $SETTINGS_JS.new
  echo "            enabled: true" >> $SETTINGS_JS.new
  echo "        }" >> $SETTINGS_JS.new
  echo "    }," >> $SETTINGS_JS.new
  sed -n -e '/the tcp port that the Node-RED web server is listening on/,$p' $SETTINGS_JS >> $SETTINGS_JS.new

  mv -f $SETTINGS_JS $SETTINGS_JS.old
  mv -f $SETTINGS_JS.new $SETTINGS_JS
else
  echo "[INFO] Disabling Projects"
  sed -i '/^[ ]*editorTheme: {/,/},/ s/^[ ]*/    \/\//' $SETTINGS_JS
fi