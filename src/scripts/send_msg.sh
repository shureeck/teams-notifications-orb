#!/bin/bash
MSG_TEMPLTE=$(cat <<END_HEREDOC  
    {"msg":"$MESSAGE"}
END_HEREDOC
)
echo "$MSG_TEMPLTE"
curl -X POST -H 'Content-type: application/json' -d "$MSG_TEMPLATE" $TEAMS_URL
