#!/bin/bash

MSG_TEMPLATE=$(cat <<END_HEREDOC {"msg":"$MESSAGE"} END_HEREDOC)


echo "$MSG_TEMPLATE"
curl -X POST -H 'Content-type: application/json' -d "$MSG_TEMPLATE" $TEAMS_URL
