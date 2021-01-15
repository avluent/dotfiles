##########################
# TMUX auto-start script #
##########################

# if installed
# AND if list doesn't contain open session
if [[ "$(command -v tmux)" ]] && \
	[[ ! "$(tmux ls)" =~ ":" ]]
then
	# setup new tmux session
	tmux new-session -s main -n main

# if installed
# AND if list contains ":" (session active)
# AND if not in session
elif [[ "$(command -v tmux)" ]] && \
	[[ "$(tmux ls)" =~ ":" ]] && \
		[[ -z "$(printenv | grep TMUX)" ]]
then
	tmux a

# if not installed
# OR inside tmux already
else
	# tmux not installed?
	echo "tmux not installed or already in active session?"
	# exit 1
fi
