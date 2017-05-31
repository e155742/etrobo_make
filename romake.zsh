#!/usr/local/bin/zsh

MAKE_OUTPUT=$(/usr/bin/make ${@} 2>&1)
STATUS=$?
echo -e "$(echo ${MAKE_OUTPUT} | grep -v -- -fno-use-cxa-atexit | sed -e "s/warning:/\\\e[35;1mwarning:\\\e[m/g" -e "s/error:/\\\e[31;1merror:\\\e[m/g")"

return ${STATUS}

