#===========================================================
# Navigation                                               #
#===========================================================
function goto {
  cd $1 && git status
}
MAJIO_HOME=/home/nyxz/dev/workspace/java/majio
FLABS_HOME=/home/nyxz/dev/workspace/futurist-labs
alias goto_majio_workspace="goto $MAJIO_HOME"
alias goto_idcamp_backend="goto $FLABS_HOME/idcamp/idcamp-backend"
alias goto_idcamp_web="goto $FLABS_HOME/idcamp/idcamp-web"
alias goto_popboardz_cms="goto $FLABS_HOME/popboardz/popboardz-cms"
alias goto_popboardz_backend="goto $FLABS_HOME/popboardz/popboardz-backend"
alias goto_larctest_backend="goto $FLABS_HOME/larctest/larctest-dev"
alias goto_larctest_cms="goto $FLABS_HOME/larctest/larctest-cms-dev"

#===========================================================
# development helpers                                      #
#===========================================================

# Majio
alias majio_eclipse_clean="pushd $MAJIO_HOME ; find . -name '.settings' -o -name '.project' -o -name '.classpath' -o -name 'target' | xargs rm -rf ; popd ;"

alias majio_edit_config="(cd ~/dev/config/majio/majio-properties && vim)"

alias majio_dump_pg_all='pg_dump -Umajio -dmajio -Fc -f ~/tmp/dump/dump.local.`date +%Y-%m-%d.%H-%M-%S`.sql'
alias majio_dump_pg_schema='pg_dump --schema-only -Umajio -dmajio -Fc -f ~/tmp/dump/schema.local.`date +%Y-%m-%d.%H-%M-%S`.sql'
alias majio_dump_pg_restore='pg_restore -e -v -Fc -Umajio -dmajio '
alias majio_pg_show_connections='watch -n 1 "psql -Umajio -dmajio -c \"SELECT * FROM pg_stat_activity;\""'
alias majio_pg_show_blocking_queries='watch -n 2 "psql -Umajio -dmajio -f ~/dev/scripts/sql/show_blocking_queries.sql"'
alias majio_pg_terminate_majio_connections='psql -Umajio -dmajio -f ~/dev/scripts/sql/terminate_majio_connections.sql'

alias majio_generate_migration_scripts='sh /home/nyxz/dev/workspaces/java/majio/scripts/shell/migration/create-migration-scripts.sh --repo /home/nyxz/dev/workspaces/java/majio --ann-repo /home/nyxz/dev/workspaces/java/majio-manual-annotation --config /home/nyxz/dev/config/majio --ssh-key /home/nyxz/.ssh/id_rsa_server_access'

alias majio_dump_download_slothworks_today="aws s3 cp s3://backup.sloth.works --include \"*`date --iso-8601`*.sql\" ."
alias majio_dump_download_majio_today="gsutil cp \"gs://majio-archive/backups/sql/maj.io/*`date --iso-8601`*\" ."
#alias majio_dump_download_slothworks_today="gsutil cp \"gs://majio-archive/backups/sql/sloth.works/*`date --iso-8601`*\" ."
#alias majio_dump_download_majio_today="gsutil cp \"gs://majio-archive/backups/sql/maj.io/*`date --iso-8601`*\" ."

# Tomcat
alias tomcat_start='sh /opt/tomcat/bin/catalina.sh start'
alias tomcat_debug='sh /opt/tomcat/bin/catalina.sh jpda start'
alias tomcat_stop='sh /opt/tomcat/bin/catalina.sh stop'
alias tomcat_show_logs='tail -f -n 100 /opt/tomcat/logs/catalina.out'

# PgAdmin
alias pgadmin4="mkdir -p ~/.pgadmin4 && docker run -d --rm --network host -v ~/.pgadmin4:/pgadmin thajeztah/pgadmin4"

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

