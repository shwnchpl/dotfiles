#!/usr/bin/bash

# Run `curl wttr.in/:help` for more info.

default_location="Portland,Maine"
default_unit="f"

while getopts ":l:u:L:" opt; do
    case ${opt} in
        l   ) opt_location=$OPTARG                  ;;
        u   ) opt_unit=$OPTARG                      ;;
        L   ) opt_lang=$OPTARG                      ;;
        \?  ) echo "Invalid option: $OPTARG" 1>&2   ;;
    esac
done

location=${opt_location:-$default_location}
unit=${opt_unit:-$default_unit}

if [[ ! -z ${opt_lang+x} ]]; then
    lang_header="Accept-Language: $opt_lang"
fi

curl -H "$lang_header" "wttr.in/$location?$unit&F" 2>/dev/null | less -RFS
