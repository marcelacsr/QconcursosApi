#!/bin/bash
set -e

: ${APP_PATH:="/usr/src/QconcursosApi"}
: ${APP_TEMP_PATH:="$APP_PATH/tmp"}
: ${APP_SETUP_LOCK:="$APP_TEMP_PATH/setup.lock"}
: ${APP_SETUP_WAIT:="5"}

# 1: Define the functions lock and unlock our app containers setup
# processes:
function lock_setup { mkdir -p $APP_TEMP_PATH && touch $APP_SETUP_LOCK; }
function unlock_setup { rm -rf $APP_SETUP_LOCK; }
function wait_setup { echo "Waiting for app setup to finish..."; sleep $APP_SETUP_WAIT; }

# 2: 'Unlock' the setup process if the script exits prematurely:
trap unlock_setup HUP INT QUIT KILL TERM EXIT

# Wait for mysql to come up
echo "DB is not ready, sleeping..."
until nc -vz mysql 3306 &>/dev/null; do
  sleep 1
done
echo "DB is ready, starting Rails."

# 3: Specify a default command, in case it wasn't issued:
if [ -z "$1" ]; then set -- bin/rails server -p 3000 -b 0.0.0.0 "$@"; fi

# 4: Run the checks only if the app code is going to be executed:
if [[ "$1" = "bin/rails" || "bash" ]]
then
  # Clean up any orphaned lock file
  unlock_setup
  # 5: Wait until the setup 'lock' file no longer exists:
  while [ -f $APP_SETUP_LOCK ]; do wait_setup; done

  # 6: 'Lock' the setup process, to prevent a race condition when the
  # project's app containers will try to install gems and setup the
  # database concurrently:
  lock_setup

 # Check if dependencies need to be installed and install them
#  gem install bundler
  touch Gemfile.lock
  bin/bundle check || bin/bundle install
#  yarn install
  # Run migrations or set up the database if it doesn't exist
  # Rails >= 6
  bin/bundle exec rails db:prepare
  # Rails < 6
  # bundle exec rake db:migrate 2>/dev/null || bundle exec rake db:setup

  # 8: 'Unlock' the setup process:
  unlock_setup

  # 9: If the command to execute is 'rails server', then we must remove any
  # pid file present. Suddenly killing and removing app containers might leave
  # this file, and prevent rails from starting-up if present:
  if [[ "$2" = "s" || "$2" = "server" ]]; then rm -rf /usr/src/QconcursosApi/tmp/pids/server.pid; fi
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
