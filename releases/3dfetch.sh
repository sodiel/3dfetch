#!/bin/sh
echo -ne '\033c\033]0;3dfetch\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/3dfetch.x86_64" "$@"
