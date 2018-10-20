API_URL=http://localhost:8080/majio-public-api

if [ -f ~/dotfiles/env.local ]; then
    . ~/dotfiles/env.local
fi

if [ -f ~/dotfiles/functions ]; then
    . ~/dotfiles/functions
fi

function majio_apiKeyOf {
   RESULT=$(psql -Umajio -dmajio -t -c "select format('%s:%s', api_key, secret) from majio_user where username ilike '$1';")
   TRIMMED=$(echo "${RESULT}" | xargs)
   echo $TRIMMED
}

function majio_apiPing {
  KEY_SECRET=$(apiKeyOf $1)
  curl -v --digest --user $KEY_SECRET --header 'Accept: text/plain' $API_URL/ping
}

function majio_uploadJob {
  # Usage: uploadJob pesho@maj.io /path/to/file.pdf
  KEY_SECRET=$(apiKeyOf $1)
  FILE_PATH=$2
  curl -v --digest --user $KEY_SECRET --header 'Accept: application/json' --file file=@$FILE_PATH $API_URL/document/uploadUrlJob
}

function majio_uploadUrlJob {
  # Usage: uploadJob pesho@maj.io http://path/to/document.{html, doc, etc.}
  KEY_SECRET=$(apiKeyOf $1)
  URL=$2
  EXPIRATION_DATE=$(date -v +2d +%Y-%m-%dT%H:%M:%S.666Z)
  curl -v --digest --user $KEY_SECRET --header 'Accept: application/json' --data "url=$URL&EXPIRY_INSTANT=$EXPIRATION_DATE" $API_URL/document/uploadUrlJob
}

function majio_deleteAllJobs {
  # Usage: deleteAllJobs pesho@maj.io
  KEY_SECRET=$(apiKeyOf $1)
  curl -v --digest --user $KEY_SECRET -X DELETE $API_URL/job/delete/all
}

function majio_angularRename {
  local source="$1";
  local target="$2";
  local BASIC_REPLACE_REGEX="s/$1/$2/g";
  local CAMEL_CASE_REGEX='s/(^|\-)([a-z])/\U\2/g';

  local source_component=$( echo "$1" | sed -r $CAMEL_CASE_REGEX );
  local target_component=$( echo "$2" | sed -r $CAMEL_CASE_REGEX );

  for file in *
  do
    sed -r "$BASIC_REPLACE_REGEX" -i "$file";
    sed -r "s/$source_component/$target_component/g" -i "$file";
    local new_filename=$( echo "$file" | sed -r "$BASIC_REPLACE_REGEX"; )
    mv $file $new_filename;
  done;
}

function majio_downloadDumpAws {
  # Usage: ~/> download_dump sloth.works ~/Downloads
  # or just: ~/> download_dump sloth.works
  local host="$1";
  local dest="$2";
  if [[ -z "$dest" ]]; then
    dest=".";
  fi
  local dump_bucket="s3://backup.$host"
  local dump_name=$(aws s3 ls "$dump_bucket" | sort -r | head -n 1 | tr -s '[:space:]' | cut -d' ' -f4)
  aws s3 cp "$dump_bucket/$dump_name" "$dest"
}

