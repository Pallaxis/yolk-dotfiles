#!/usr/bin/env bash
# Mounts the home dir of the supplied argument

mount() {
    SHARE_DIR="${HOME}share"
    FULL_PATH=$SHARE_DIR/$1

    if [[ ! -d $FULL_PATH ]]; then
        mkdir $FULL_PATH
    fi

    if [ -z "$(ls -A $FULL_PATH)" ]; then
        echo "sshfs $1: $FULL_PATH -o idmap=user"
    else
        echo "Directory isn't empty or is already mounted to"
    fi
}

unmount() {
    echo "unmount called $2"
}


case "$1" in
    --help|-h)
        echo "Usage ssh-mount.sh --[OPTION] [SERVER]"
        echo "Options:"
        echo "--help, -h            Show this help screen"
        echo "--mount, -m           Mount home of supplied server argument"
        echo "--unmount, -h         Unmount a mounted server"
        ;;
    --mount|-m)
        if [ -z "$2" ]; then
            mount $2
        else
            echo "Must supply an argument"
        fi
        ;;
    --unmount|-u)
        if [ -z "$2" ]; then
            unmount $2
        else
            echo "Must supply an argument"
        fi
        ;;
    *)
        echo "Invalid argument supplied, use --help for usage information"
        ;;
esac
