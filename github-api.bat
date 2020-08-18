set REPO=%1
if _%REPO% == _ set REPO=github-package

set WORKFLOW=main.yml

:: List repository tags (HTTP GET)
curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/trundev/%REPO%/tags

:: Create a repository dispatch event (HTTP POST)
:: https://docs.github.com/en/rest/reference/repos#create-a-repository-dispatch-event
curl -X POST -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/trundev/%REPO%/dispatches -d "{\"event_type\": \"event_type\", \"client_payload\": \"Payload\"}"

:: Create a workflow dispatch event (HTTP POST)
:: https://docs.github.com/en/rest/reference/actions#create-a-workflow-dispatch-event
curl -X POST -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/trundev/%REPO%/actions/workflows/%WORKFLOW%/dispatches -d "{\"ref\": \"ref\", \"inputs\": \"Inputs\"}"
