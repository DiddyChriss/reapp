from __future__ import print_function

import json
import logging

import boto3
import os
import urllib3
from base64 import b64encode

codepipeline_client = boto3.client('codepipeline')
integration_user = os.environ['INTEGRATION_AUTH_USER']
integration_pass = os.environ['INTEGRATION_AUTH_PASS']
integration_type = os.environ['INTEGRATION_TYPE']
user_pass = integration_user + ":" + integration_pass

logger = logging.getLogger()
logger.setLevel(logging.INFO)

region = os.environ['AWS_REGION']

STATUS_MAPPING = {
    "INPROGRESS": "pending",
    "STARTED": "pending",
    "STOPPED": "pending",
    "STOPPING": "pending",
    "SUPERSEDED": "pending",
    "RESUMED": "pending",
    "SUCCEEDED": "success",
    "FAILED": "error",
}


def _set_stages(action: dict, stages: list) -> list:
    """Set stages of the pipeline execution for GitHub status checks."""
    stages.append(
        {
            "name": action['actionName'],
            "status": STATUS_MAPPING[action['status'].upper()],
        }
    )

    return stages


def _set_stage_status(stage_name: str, stage_status: str, message_data: dict) -> dict:
    """Prepare status of specific stages for `_send_request` method."""
    target_url = "https://" + region + ".console.aws.amazon.com/codesuite/codepipeline/pipelines/" + \
                                 message_data['detail']['pipeline'] + "/executions/" + message_data['detail'][
                                     'execution-id'] + "?region=" + region

    return {
        "state": stage_status,
        "context": stage_name,
        "description": message_data['detail']['pipeline'],
        "target_url": target_url
    }


def _send_request(commit_id: str, stage_status_data: dict, repo_id: str = None) -> None:
    """Send request to GitHub API to update status of the commit."""
    http = urllib3.PoolManager()
    url = "https://api.github.com/repos/" + repo_id + "/statuses/" + commit_id
    encode_user_pass = b64encode(user_pass.encode()).decode()

    request_action = http.request('POST', url,
                                      headers={'Accept': 'application/json', 'Content-Type': 'application/json',
                                               'User-Agent': 'Curl/0.1',
                                               'Authorization': 'Basic %s' % encode_user_pass},
                                      body=json.dumps(stage_status_data).encode('utf-8')
                                      )

    logger.info("Request Action Send: %s", request_action.data)


def lambda_handler(event, context):
    message = event['Records'][0]['Sns']['Message']
    message_data = json.loads(message)
    logger.info("Data: %s", message_data)

    # Push only notifications about Pipeline Execution State Changes
    if message_data.get("detailType") != "CodePipeline Pipeline Execution State Change":
        return ()

    response_pipline = codepipeline_client.get_pipeline_execution(
        pipelineName=message_data['detail']['pipeline'],
        pipelineExecutionId=message_data['detail']['execution-id']
    )

    logger.info("Response Pipeline: %s", response_pipline)

    response_pipline_stages = codepipeline_client.list_action_executions(
        pipelineName=message_data['detail']['pipeline'],
        filter={'pipelineExecutionId': message_data['detail']['execution-id']}
    )['actionExecutionDetails'][::-1]

    logger.info("Response Pipeline Stages: %s", response_pipline_stages)

    artifact_revisions = response_pipline['pipelineExecution'].get('artifactRevisions')
    commit_id = artifact_revisions[0]['revisionId']
    revision_url = artifact_revisions[0]['revisionUrl']

    if "FullRepositoryId=" in revision_url:
        repo_id = revision_url.split("FullRepositoryId=")[1].split("&")[0]

    pipeline_status = STATUS_MAPPING[message_data['detail']['state'].upper()]

    stages = [
        {
            "name": "CodePipeline",
            "status": pipeline_status
        }
    ]

    for action in response_pipline_stages:
        if "Test" not in response_pipline_stages:
            stages.append(
                {
                    "name": "Test",
                    "status": STATUS_MAPPING["INPROGRESS"]
                        if pipeline_status == STATUS_MAPPING["INPROGRESS"]
                        else STATUS_MAPPING["FAILED"],
                }
            )
        _set_stages(action, stages)

    for stage in stages:
        _send_request(commit_id, _set_stage_status(stage["name"], stage["status"], message_data), repo_id)

    return message
