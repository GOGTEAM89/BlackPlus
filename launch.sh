THIS_DIR=$(cd $(dirname $0); pwd);cd $THIS_DIR

tmux kill-session -t "bot=$THIS_DIR"
tmux new-session -s "bot=$THIS_DIR" -d
tmux send "./TD-Refresh" C-m
tmux rename-window "global=TDBot - Auto refresh"

tmux new-window
tmux send "cd Helper;./script" C-m
tmux rename-window "$THIS_DIR=BlackPlus - API Helper"

tmux new-window
if [ "$1" = "config" ]; then 
    tmux send "./script config" C-m 
    echo -e "\033[0;35mTDBot config creator enabled!\033[0m"
    sleep 1
elif [ "$1" = "install" ]; then 
    tmux send "./script install" C-m
    echo -e "\033[0;35mTDBot installer enabled!\033[0m"
    sleep 1
else
    tmux send "./script" C-m
fi
tmux rename-window "$THIS_DIR=BlackPlus - CLI TDBot"
	
echo -e "\033[0;32m----------------------------------------------------------------------\033[0m"
toilet -f bigmono9 -F gay B-Launcher
echo -e "\033[0;32m----------------------------------------------------------------------\033[0m"
sleep 1
echo -e "\033[0;35mB-Launcher is ready!\033[0m"
sleep 1

tmux attach
