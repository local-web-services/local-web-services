"""AWS CloudFormation action handler functions."""

from __future__ import annotations

import uuid

from fastapi import Response

from lws.providers.cloudformation._cfn_state import _CfnState

_REGION = "us-east-1"
_NS = "http://cloudformation.amazonaws.com/doc/2010-05-15/"


def _request_id() -> str:
    return str(uuid.uuid4())


def _stack_arn(account_id: str, stack_name: str, stack_uid: str) -> str:
    return f"arn:aws:cloudformation:{_REGION}:{account_id}:stack/{stack_name}/{stack_uid}"


def _xml_ok(body: str) -> Response:
    return Response(
        content=f'<?xml version="1.0" encoding="UTF-8"?>\n{body}',
        status_code=200,
        media_type="text/xml",
    )


def _xml_error(code: str, message: str, status_code: int = 400) -> Response:
    return Response(
        content=(
            f'<?xml version="1.0" encoding="UTF-8"?>'
            f'<ErrorResponse xmlns="{_NS}">'
            f"<Error><Code>{code}</Code><Message>{message}</Message></Error>"
            f"<RequestId>{_request_id()}</RequestId>"
            f"</ErrorResponse>"
        ),
        status_code=status_code,
        media_type="text/xml",
    )


def _stack_xml(stack: dict) -> str:
    last_updated = (
        f"<LastUpdatedTime>{stack['LastUpdatedTime']}</LastUpdatedTime>"
        if "LastUpdatedTime" in stack
        else ""
    )
    return (
        "<member>"
        f"<StackId>{stack['StackId']}</StackId>"
        f"<StackName>{stack['StackName']}</StackName>"
        f"<StackStatus>{stack['StackStatus']}</StackStatus>"
        f"<CreationTime>{stack['CreationTime']}</CreationTime>"
        f"{last_updated}"
        "</member>"
    )


async def _handle_create_stack(
    state: _CfnState, params: dict[str, str], account_id: str
) -> Response:
    stack_name = params.get("StackName", "")
    if not stack_name:
        return _xml_error("ValidationError", "StackName is required")
    if stack_name in state.stacks:
        return _xml_error(
            "AlreadyExistsException",
            f"Stack [{stack_name}] already exists",
            status_code=400,
        )
    stack_uid = str(uuid.uuid4())
    stack_id = _stack_arn(account_id, stack_name, stack_uid)
    state.stacks[stack_name] = {
        "StackId": stack_id,
        "StackName": stack_name,
        "StackStatus": "CREATE_COMPLETE",
        "TemplateBody": params.get("TemplateBody", ""),
        "CreationTime": "2024-01-01T00:00:00Z",
    }
    rid = _request_id()
    return _xml_ok(
        f'<CreateStackResponse xmlns="{_NS}">'
        f"<CreateStackResult><StackId>{stack_id}</StackId></CreateStackResult>"
        f"<ResponseMetadata><RequestId>{rid}</RequestId></ResponseMetadata>"
        f"</CreateStackResponse>"
    )


async def _handle_update_stack(
    state: _CfnState, params: dict[str, str], _account_id: str
) -> Response:
    stack_name = params.get("StackName", "")
    if stack_name not in state.stacks:
        return _xml_error(
            "StackNotFoundException",
            f"Stack with id {stack_name} does not exist",
            status_code=400,
        )
    stack = state.stacks[stack_name]
    stack["StackStatus"] = "UPDATE_COMPLETE"
    stack["TemplateBody"] = params.get("TemplateBody", stack["TemplateBody"])
    stack["LastUpdatedTime"] = "2024-01-01T00:00:01Z"
    rid = _request_id()
    return _xml_ok(
        f'<UpdateStackResponse xmlns="{_NS}">'
        f"<UpdateStackResult><StackId>{stack['StackId']}</StackId></UpdateStackResult>"
        f"<ResponseMetadata><RequestId>{rid}</RequestId></ResponseMetadata>"
        f"</UpdateStackResponse>"
    )


async def _handle_delete_stack(
    state: _CfnState, params: dict[str, str], _account_id: str
) -> Response:
    stack_name = params.get("StackName", "")
    state.stacks.pop(stack_name, None)
    rid = _request_id()
    return _xml_ok(
        f'<DeleteStackResponse xmlns="{_NS}">'
        f"<ResponseMetadata><RequestId>{rid}</RequestId></ResponseMetadata>"
        f"</DeleteStackResponse>"
    )


async def _handle_describe_stacks(
    state: _CfnState, params: dict[str, str], _account_id: str
) -> Response:
    filter_name = params.get("StackName", "")
    if filter_name:
        if filter_name not in state.stacks:
            return _xml_error(
                "StackNotFoundException",
                f"Stack with id {filter_name} does not exist",
                status_code=400,
            )
        stacks = [state.stacks[filter_name]]
    else:
        stacks = list(state.stacks.values())
    members = "".join(_stack_xml(s) for s in stacks)
    rid = _request_id()
    return _xml_ok(
        f'<DescribeStacksResponse xmlns="{_NS}">'
        f"<DescribeStacksResult><Stacks>{members}</Stacks></DescribeStacksResult>"
        f"<ResponseMetadata><RequestId>{rid}</RequestId></ResponseMetadata>"
        f"</DescribeStacksResponse>"
    )


async def _handle_list_stacks(
    state: _CfnState, params: dict[str, str], _account_id: str
) -> Response:
    status_filters: set[str] = set()
    i = 1
    while True:
        key = f"StackStatusFilter.member.{i}"
        val = params.get(key)
        if val is None:
            break
        status_filters.add(val)
        i += 1

    summaries = []
    for stack in state.stacks.values():
        if status_filters and stack["StackStatus"] not in status_filters:
            continue
        summaries.append(
            "<member>"
            f"<StackId>{stack['StackId']}</StackId>"
            f"<StackName>{stack['StackName']}</StackName>"
            f"<StackStatus>{stack['StackStatus']}</StackStatus>"
            "</member>"
        )
    members = "".join(summaries)
    rid = _request_id()
    return _xml_ok(
        f'<ListStacksResponse xmlns="{_NS}">'
        f"<ListStacksResult><StackSummaries>{members}</StackSummaries></ListStacksResult>"
        f"<ResponseMetadata><RequestId>{rid}</RequestId></ResponseMetadata>"
        f"</ListStacksResponse>"
    )


async def _handle_describe_stack_events(
    state: _CfnState, params: dict[str, str], _account_id: str
) -> Response:
    stack_name = params.get("StackName", "")
    if stack_name not in state.stacks:
        return _xml_error(
            "StackNotFoundException",
            f"Stack with id {stack_name} does not exist",
            status_code=400,
        )
    stack = state.stacks[stack_name]
    event_id = str(uuid.uuid4())
    event = (
        "<member>"
        f"<EventId>{event_id}</EventId>"
        f"<StackId>{stack['StackId']}</StackId>"
        f"<StackName>{stack_name}</StackName>"
        f"<LogicalResourceId>{stack_name}</LogicalResourceId>"
        f"<ResourceType>AWS::CloudFormation::Stack</ResourceType>"
        f"<ResourceStatus>{stack['StackStatus']}</ResourceStatus>"
        f"<Timestamp>2024-01-01T00:00:00Z</Timestamp>"
        "</member>"
    )
    rid = _request_id()
    return _xml_ok(
        f'<DescribeStackEventsResponse xmlns="{_NS}">'
        f"<DescribeStackEventsResult>"
        f"<StackEvents>{event}</StackEvents>"
        f"</DescribeStackEventsResult>"
        f"<ResponseMetadata><RequestId>{rid}</RequestId></ResponseMetadata>"
        f"</DescribeStackEventsResponse>"
    )


_ACTION_HANDLERS = {
    "CreateStack": _handle_create_stack,
    "UpdateStack": _handle_update_stack,
    "DeleteStack": _handle_delete_stack,
    "DescribeStacks": _handle_describe_stacks,
    "ListStacks": _handle_list_stacks,
    "DescribeStackEvents": _handle_describe_stack_events,
}
