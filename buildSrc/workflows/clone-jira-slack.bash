#!/bin/bash -ex

urlMarkdown() {
    echo "<${1}|${2}>"
}

# Main

for testVar in CLONE_JIRA_ERROR CLONE_JIRA_RESULT CLONE_JIRA_STORY INPUTS MOVE_TICKET_RESULT WORKFLOW_RUN_URL USER GITHUB_ENV; do
    if [[ -z ${!testVar+x} ]]; then
        echo "Error: $testVar is unset"
        exit 1
    fi
done

storyMarkdown="$(urlMarkdown "https://belmonttechinc.atlassian.net/browse/${CLONE_JIRA_STORY}" "${CLONE_JIRA_STORY}")"
if [[ "$CLONE_JIRA_RESULT" == "success" && "$MOVE_TICKET_RESULT" == "success" ]]; then
    msg=":greencircle: $(urlMarkdown "$WORKFLOW_RUN_URL" "Success") - continuation: $storyMarkdown"
elif [[ "$CLONE_JIRA_RESULT" == "success" && "$MOVE_TICKET_RESULT" == "failure" ]]; then
    msg=":red_circle: $(urlMarkdown "$WORKFLOW_RUN_URL" "Move ticket failure") - continuation: $storyMarkdown"
else
    msg=":red_circle: $(urlMarkdown "$WORKFLOW_RUN_URL" "Failure")"
fi

msg="${msg}\n*User:* $USER\n*Inputs:* $INPUTS"
[[ "$CLONE_JIRA_RESULT" != "success" ]] && msg="${msg}\n*Error:* $CLONE_JIRA_ERROR"

echo "SLACK_MESSAGE=${msg}" >> "$GITHUB_ENV"
