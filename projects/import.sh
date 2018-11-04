projects=( 'coursera' 'flabs' 'majio' )

for project in $projects; do
  PROJ_HOME="$DOTFILES_HOME/projects/$project"

  ENV_FILE="$PROJ_HOME/env.sh"
  if [ -f "$ENV_FILE" ]; then
    . "$ENV_FILE"
  fi

  FUNC_FILE="$PROJ_HOME/functions.sh"
  if [ -f "$FUNC_FILE" ]; then
    . "$FUNC_FILE"
  fi

  ALIAS_FILE="$PROJ_HOME/aliases.sh"
  if [ -f "$ALIAS_FILE" ]; then
    . "$ALIAS_FILE"
  fi
done;
