set REPO=%1
if _%REPO% == _ set REPO=github-package

set WORKFLOW=main.yml
set WORKFLOW_REF=master
set WORKFLOW_INPUTS={\"IMAGE_NAME\": \"test-package\"}

set OPT=
set OPT=-H "Accept: application/vnd.github.v3+json" %OPT%
::set OPT=--user trundev:<set GITHUB_TOKEN here> %OPT%
set OPT=--user trundev %OPT%

@echo ===============================
@echo List repository tags (HTTP GET)
curl %OPT% https://api.github.com/repos/trundev/%REPO%/tags
@echo.

::See https://docs.github.com/en/rest/reference/repos#create-a-repository-dispatch-event
@echo ==============================================
@echo Create a repository dispatch event (HTTP POST)
curl -X POST %OPT% https://api.github.com/repos/trundev/%REPO%/dispatches -d "{\"event_type\": \"my_event_type\", \"client_payload\": {}}"
@echo.

::See https://docs.github.com/en/rest/reference/actions#create-a-workflow-dispatch-event
@echo ============================================
@echo Create a workflow dispatch event (HTTP POST)
curl -X POST %OPT% https://api.github.com/repos/trundev/%REPO%/actions/workflows/%WORKFLOW%/dispatches -d "{\"ref\": \"%WORKFLOW_REF%\", \"inputs\": %WORKFLOW_INPUTS%}"
@echo.
