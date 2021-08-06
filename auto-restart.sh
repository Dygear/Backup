#!/bin/bash

until ./recorder; do
    echo "Server 'Trunk-Recoder' crashed with exit code $?. Respawning." >&2
    sleep 5
done

