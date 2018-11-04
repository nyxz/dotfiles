#===========================================================
# Navigation                                               #
#===========================================================
alias goto_majio_workspace="goto $MAJIO_HOME"

#===========================================================
# Helpers
#===========================================================
alias majio_eclipse_clean="pushd $MAJIO_HOME ; find . -name '.settings' -o -name '.project' -o -name '.classpath' -o -name 'target' | xargs rm -rf ; popd ;"

alias majio_edit_config="(cd ~/dev/config/majio/majio-properties && vim)"

alias majio_dump_pg_all='pg_dump -Umajio -dmajio -Fc -f ~/tmp/dump/dump.local.`date +%Y-%m-%d.%H-%M-%S`.sql'
alias majio_dump_pg_schema='pg_dump --schema-only -Umajio -dmajio -Fc -f ~/tmp/dump/schema.local.`date +%Y-%m-%d.%H-%M-%S`.sql'
alias majio_dump_pg_restore='pg_restore -e -v -Fc -Umajio -dmajio '
alias majio_pg_show_connections='watch -n 1 "psql -Umajio -dmajio -c \"SELECT * FROM pg_stat_activity;\""'
alias majio_pg_show_blocking_queries='watch -n 2 "psql -Umajio -dmajio -f ~/dev/scripts/sql/show_blocking_queries.sql"'
alias majio_pg_terminate_majio_connections='psql -Umajio -dmajio -f ~/dev/scripts/sql/terminate_majio_connections.sql'

alias majio_generate_migration_scripts='sh /home/nyxz/dev/workspaces/java/majio/scripts/shell/migration/create-migration-scripts.sh --repo /home/nyxz/dev/workspaces/java/majio --ann-repo /home/nyxz/dev/workspaces/java/majio-manual-annotation --config /home/nyxz/dev/config/majio --ssh-key /home/nyxz/.ssh/id_rsa_server_access'

alias majio_dump_download_slothworks_today="aws s3 cp s3://backup.sloth.works --include \"*`date +%Y-%m-%d`*.sql\" ."
alias majio_dump_download_majio_today="gsutil cp \"gs://majio-archive/backups/sql/maj.io/*`date +%Y-%m-%d`*\" ."
#alias majio_dump_download_slothworks_today="gsutil cp \"gs://majio-archive/backups/sql/sloth.works/*`date +%Y-%m-%d`*\" ."
#alias majio_dump_download_majio_today="gsutil cp \"gs://majio-archive/backups/sql/maj.io/*`date +%Y-%m-%d`*\" ."

