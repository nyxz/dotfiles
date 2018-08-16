FLABS_API_URL=""
FLABS_USER=""
FLABS_PASS=""
FLABS_SESSION=""

# env.local contains application credentials that can be activated by using
# flabs_activate function. Credentials have the following naming convention:
# <APP_NAME>_API_URL, <APP-NAME>_USER and <APP-NAME>_PASS
if [ -f ~/dotfiles/env.local ]; then
    . ~/dotfiles/env.local
fi

if [ -f ~/dotfiles/functions ]; then
    . ~/dotfiles/functions
fi


function flabs_activate {
  local app_name=$( echo "$1" | tr a-z A-Z )
  printf "Activating credentials for application $app_name\n"
  FLABS_USER=$(eval echo "\$${app_name}_USER")
  FLABS_PASS=$(eval echo "\$${app_name}_PASS")
  FLABS_API_URL=$(eval echo "\$${app_name}_API_URL")
  if [[ -z "$FLABS_USER" ]]; then
    printf "User not found for application $app_name\n"
    return 1
  fi
  if [[ -z "$FLABS_PASS" ]]; then
    printf "Password not found for application $app_name\n"
    return 1
  fi
  if [[ -z "$FLABS_API_URL" ]]; then
    printf "API URL not found for application $app_name\n"
    return 1
  fi
  printf "Credentials activated successfully.\n"
}

# Create session if currently there is currently not existing one
function flabs_create_session {

  while :; do
    case "$1" in
      -f|--force)
        printf "Forcing creation of new session\n"
        flabs_delete /sessions
        FLABS_SESSION=""
        break;
        ;;
      --)
        shift
        break
        ;;
      *)
        break
    esac
    shift
  done

  if [[ -z "$FLABS_SESSION" ]]; then
    printf "Creating session LarcTest on $FLABS_API_URL\n"
    local session_resp=$( flabs_post_pub /sessions "{\"username\":\"$FLABS_USER\",\"password\":\"$FLABS_PASS\"}" )
    FLABS_SESSION=$( echo "$session_resp" | jq '.sessionId' --raw-output )
    if [[ -z "$FLABS_SESSION" ]]; then
      printf "Couldn't create session\n"
      return 1
    fi
    printf "Session created $FLABS_SESSION\n"
  else
    printf "Working with currently established session $FLABS_SESSION\n"
  fi
}

# Make GET requests that require session
function flabs_get {
  local url="$FLABS_API_URL$1";
  flabs_create_session
  if [[ -z "$FLABS_SESSION" ]]; then
    return 1
  fi
  printf "\n=================================================\n" >&2
  printf "\ncurl -H \"Content-Type: application/json\" -H \"X-Auth-Token: $FLABS_SESSION\" \"$url\"\n" >&2
  printf "\n=================================================\n" >&2
  curl -H "Content-Type: application/json" -H "X-Auth-Token: $FLABS_SESSION" "$url" | jq
}

# Make public POST calls - no need of session
function flabs_post_pub {
  local url="$FLABS_API_URL$1";
  local json="$2";
  printf "\n=================================================\n" >&2
  printf "\ncurl -X POST -d\"$json\" -H \"Content-Type: application/json\" \"$url\"\n" >&2
  printf "\n=================================================\n" >&2
  curl -X POST -d"$json" -H "Content-Type: application/json" "$url"
}

# Make POST requests that require session
function flabs_post_raw {
  local url="$FLABS_API_URL$1";
  local json="$2";
  flabs_create_session
  if [[ -z "$FLABS_SESSION" ]]; then
    return 1
  fi
  printf "\n=================================================\n" >&2
  printf "\ncurl -X POST -d\"$json\" -H \"Content-Type: application/json\" -H \"X-Auth-Token: $FLABS_SESSION\" \"$url\"\n" >&2
  printf "\n=================================================\n" >&2
  curl -X POST -d"$json" -H "Content-Type: application/json" -H "X-Auth-Token: $FLABS_SESSION" "$url"
}

function flabs_post {
  flabs_post_raw $1 $2 | jq
}

function flabs_delete {
  local url="$FLABS_API_URL$1"
  curl -X DELETE -H "X-Auth-Token: $FLABS_SESSION" "$url"
}

