
export SECRET_KEY_BASE=W68eso5YQOlbtvSNUR50N/HDWj6IaEhAwMR3LtzuBEQAefwYVbX84bvoTA7XtiGi
export MIX_ENV=prod
export PORT=4747

echo "Stopping old copy of app, if any..."

_build/prod/rel/bulls_and_cows/bin/bulls_and_cows stop || true

echo "Starting app..."

_build/prod/rel/bulls_and_cows/bin/bulls_and_cows start

# TODO: DONE. Add a systemd service file
#       to start your app on system boot.
