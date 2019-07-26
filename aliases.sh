#===========================================================
# development helpers                                      #
#===========================================================

# Tomcat
alias tomcat_start='sh /opt/tomcat/bin/catalina.sh start'
alias tomcat_debug='sh /opt/tomcat/bin/catalina.sh jpda start'
alias tomcat_stop='sh /opt/tomcat/bin/catalina.sh stop'
alias tomcat_show_logs='tail -f -n 100 /opt/tomcat/logs/catalina.out'

# PgAdmin
alias pgadmin4="mkdir -p ~/.pgadmin4 && docker run -d --rm --network host -v ~/.pgadmin4:/pgadmin thajeztah/pgadmin4"

# Docker
# Docker Anaconda
alias docker_jupyter="docker run -i -t -v /home/nyxz/dev/workspaces/datascience/jupyter/notebooks:/opt/notebooks -p 8888:8888 continuumio/anaconda3 /bin/bash -c \"/opt/conda/bin/conda install jupyter r r-essentials -y && /opt/conda/bin/jupyter notebook --notebook-dir=/opt/notebooks --ip='*' --port=8888 --no-browser --allow-root\""

#===========================================================
# General purpose aliases                                  #
#===========================================================
alias ll='ls -lh'
alias clipboard='xclip -sel clip'
alias distro='head -n 1 /etc/issue'
alias remove_utf8_bom="sed -i '1 s/^\xef\xbb\xbf//'"
alias p='ps -aef | grep -i '
alias sizeme='du -h --max-depth=1'
alias sizeme_big='du -h --max-depth=1 --threshold=+10m'
alias heap_dump='jmap -dump:format=b,file=/home/nyxz/tmp/heap.`date +%Y-%m-%d.%H-%M-%S`.dump'
alias eclipse_clean="find . -name '.settings' -o -name '.project' -o -name '.classpath' -o -name 'target' | xargs rm -rf ;"

alias ok='notify-send "Operation succeeded!" && paplay ~/Dropbox/sounds/success.wav'
alias nok='notify-send "Operation failed." && paplay ~/Dropbox/sounds/fail.wav'

alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

