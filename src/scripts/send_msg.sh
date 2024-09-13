#!/bin/bash
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
                                "text": "$MESSAGE,
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
                            },{
                                "type": "Action.OpenUrl",
                                "url": "https://output.circle-artifacts.com/output/job/$CIRCLE_WORKFLOW_JOB_ID/artifacts/0/allure-report/index.html",
                                "title": "View Report"
                            }
                           ]
                          }
                         }
                       ]
           }
END_HEREDOC
)
echo "$MSG_TEMPLTE"
curl -X POST -H 'Content-type: application/json' -d "$MSG_TEMPLTE" "$TEAMS_URL"
