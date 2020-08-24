set REPO=%1
if _%REPO% == _ set REPO=github-package

set WORKFLOW=main.yml
set WORKFLOW_REF=delete-package
set WORKFLOW_INPUTS={\"NAME\": \"test-github-package\"}

set OPT=
set OPT=-H "Accept: application/vnd.github.v3+json" %OPT%
::set OPT=--user trundev:<set GITHUB_TOKEN here> %OPT%
set OPT=--user trundev %OPT%

@echo ===============================
@echo List repository tags (HTTP GET)
curl %OPT% https://api.github.com/repos/trundev/%REPO%/tags
@echo.

::See https://docs.github.com/en/rest/reference/actions#create-a-workflow-dispatch-event
@echo ============================================
@echo Create a workflow dispatch event (HTTP POST)
curl -X POST %OPT% https://api.github.com/repos/trundev/%REPO%/actions/workflows/%WORKFLOW%/dispatches -d "{\"ref\": \"%WORKFLOW_REF%\", \"inputs\": %WORKFLOW_INPUTS%}"
@echo.
