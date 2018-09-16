#!/bin/sh

if [ ! -f data/.setup_done ]; then
    ADMIN_MODIFIED=$(date +%s)
    ADMIN_CREATED=$ADMIN_MODIFIED

    sed -i "s/##ADMIN_USERNAME##/$ADMIN_USERNAME/g" conf/setup.json
    sed -i "s/##ADMIN_FULLNAME##/$ADMIN_FULLNAME/g" conf/setup.json
    sed -i "s/##ADMIN_EMAIL##/$ADMIN_EMAIL/g" conf/setup.json
    sed -i "s/##ADMIN_MODIFIED##/$ADMIN_MODIFIED/g" conf/setup.json
    sed -i "s/##ADMIN_CREATED##/$ADMIN_CREATED/g" conf/setup.json

    bin/control.sh setup
    bin/control.sh admin "$ADMIN_USERNAME" "$ADMIN_PASSWORD"

    # Additional init scripts
    for f in /init-scripts.d/*; do
        [ -e "$f" ] || continue
        if [ -x "$f" ]; then
            echo "Running init script $f"
            "$f"
        else
            echo "Init script $f ignored because it's not executable."
        fi
    done

    touch data/.setup_done
fi

# Additional init scripts
for f in /init-scripts.d/*; do
    [ -e "$f" ] || continue
    if [ -x "$f" ]; then
        echo "Running startup script $f"
        "$f"
    else
        echo "Startup script $f ignored because it's not executable."
    fi
done

echo "Cronicle started."
node ./lib/main.js --foreground "$@"
