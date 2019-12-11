#!/bin/sh
echo "Nginx Server Started"

if [[ $CONFIG_VARS ]]; then
  echo "Writing config vars"
  echo $CONFIG_VARS
  SPLIT=$(echo $CONFIG_VARS | tr "," "\n")
  ARGS=
  for VAR in ${SPLIT}; do
      ARGS="${ARGS} -v ${VAR} "
  done

  JSON=`json_env --json $ARGS`

  echo " ==> Writing /app/env.js with ${JSON}"

  echo "window.process = window.process || {}; window.process.env = ${JSON};" > /app/env.js
fi

exec "$@"