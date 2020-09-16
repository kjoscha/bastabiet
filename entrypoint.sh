#! /bin/sh
bundle exec rake db:create db:migrate

# Unicorn cant create this dir
mkdir -p /bastabiet/tmp/pids

rm -rf /bastabiet/tmp/pids/server.pid
exec "$@"
