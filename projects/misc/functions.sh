
function devenv {
	if [ $# -ne 2 ]; then
		echo "You need to pass 2 arguments: profile and modification"
		return
	fi

	local profile=$1
	local mod=$2

	source $DEV_ENVS/$profile/$mod
}

function devenv_unset {
	if [ $# -ne 1 ]; then
		echo "You need to pass the profile"
		return
	fi

	local profile=$1

	vars=$( grep -rh "^export" $DEV_ENVS/$profile | sed "s/export \(.*\)\=.*$/\1/p" | sort | uniq )
	while IFS= read -r line; do
		echo "unset $line"
		unset "$line"
	done <<< "$vars"
}

