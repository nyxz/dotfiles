
function devenv {
	if [ $# -ne 2 ]; then
		echo "You need to pass 2 arguments: profile and modification"
		return
	fi

	local profile=$1
	local mod=$2

	source $DEV_ENVS/$profile/$mod
}

