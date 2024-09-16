#!/bin/
if [$REPORT_URL -ne ""]
then
REPORT_BUTTON=$(cat <<END_HEREDOC
,{
                                "type": "Action.OpenUrl",
                                "url": "$REPORT_URL",
                                "title": "View Report"
                            }
END_HEREDOC
)
fi
else REPORT_BUTTON=""

MSG_TEMPLTE=$(cat <<END_HEREDOC  
    {
            "type": "message",
            "attachments": [{
                    "contentType": "application/vnd.microsoft.card.adaptive",
                    "contentUrl": null,
                    "content": {
                        "\$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
                        "type": "AdaptiveCard",
                        "version": "1.4",
                        "msteams": {
                            "width": "Full"
                        },
                        "body": [{
                                "type": "Container",
                                "style": "$COLOR",
                                "bleed": true,
                                "minHeight": "5px",
                                "separator": "true",
                                "items": [{
                                        "type": "TextBlock",
                                        "text": " ",
                                        "size": "small"
                                    }
                                ]
                            }, {
                                "type": "TextBlock",
                                "text": "$MESSAGE",
                                "style": "heading",
                                "weight": "bolder",
                                "size": "large"
                            }, {
                                "type": "FactSet",
                                "facts": [{
                                        "title": "Project",
                                        "value": "$CIRCLE_PROJECT_REPONAME"
                                    }, {
                                        "title": "Job Number",
                                        "value": "$CIRCLE_BUILD_NUM"
                                    }
                                ]
                            }
                        ],
                        "actions": [{
                                "type": "Action.OpenUrl",
                                "url": "$CIRCLE_BUILD_URL",
                                "title": "Visit Job"
                            }
                            $REPORT_BUTTON
                           ]
                          }
                         }
                       ]
           }
END_HEREDOC
)
echo "$MSG_TEMPLTE"
echo "$TEAMS_URL"
curl -X POST -H 'Content-type: application/json' -d "$MSG_TEMPLTE" "$TEAMS_URL"
