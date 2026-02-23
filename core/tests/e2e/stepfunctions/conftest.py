"""Shared fixtures for stepfunctions E2E tests."""

from __future__ import annotations

import json

from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})
UPDATED_DEFINITION = json.dumps(
    {"StartAt": "PassUpdated", "States": {"PassUpdated": {"Type": "Pass", "End": True}}}
)
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


# ── Step definitions ──────────────────────────────────────────────────


@given(
    parsers.parse('a state machine "{name}" was created with a Pass definition'),
    target_fixture="created_state_machine",
)
def a_state_machine_was_created(name, lws_invoke, e2e_port):
    lws_invoke(
        [
            "stepfunctions",
            "create-state-machine",
            "--name",
            name,
            "--definition",
            PASS_DEFINITION,
            "--role-arn",
            ROLE_ARN,
            "--port",
            str(e2e_port),
        ]
    )
    return {"name": name}


@given(
    parsers.parse('an execution was started on state machine "{name}" with input "{input_json}"'),
    target_fixture="started_execution",
)
def an_execution_was_started(name, input_json, lws_invoke, e2e_port):
    start_output = lws_invoke(
        [
            "stepfunctions",
            "start-execution",
            "--name",
            name,
            "--input",
            input_json,
            "--port",
            str(e2e_port),
        ]
    )
    return {"executionArn": start_output["executionArn"]}


@given(
    parsers.parse('an EXPRESS state machine "{name}" was created with a Pass definition'),
    target_fixture="created_state_machine",
)
def an_express_state_machine_was_created(name, lws_invoke, e2e_port):
    lws_invoke(
        [
            "stepfunctions",
            "create-state-machine",
            "--name",
            name,
            "--definition",
            PASS_DEFINITION,
            "--type",
            "EXPRESS",
            "--port",
            str(e2e_port),
        ]
    )
    return {"name": name}


@when(
    parsers.parse('I create a state machine named "{name}" with a Pass definition'),
    target_fixture="command_result",
)
def i_create_state_machine(name, e2e_port):
    return runner.invoke(
        app,
        [
            "stepfunctions",
            "create-state-machine",
            "--name",
            name,
            "--definition",
            PASS_DEFINITION,
            "--role-arn",
            ROLE_ARN,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete state machine "{name}"'),
    target_fixture="command_result",
)
def i_delete_state_machine(name, e2e_port):
    return runner.invoke(
        app,
        [
            "stepfunctions",
            "delete-state-machine",
            "--name",
            name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I describe the started execution",
    target_fixture="command_result",
)
def i_describe_started_execution(started_execution, e2e_port):
    return runner.invoke(
        app,
        [
            "stepfunctions",
            "describe-execution",
            "--execution-arn",
            started_execution["executionArn"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I describe state machine "{name}"'),
    target_fixture="command_result",
)
def i_describe_state_machine(name, e2e_port):
    return runner.invoke(
        app,
        [
            "stepfunctions",
            "describe-state-machine",
            "--name",
            name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I get execution history for the started execution",
    target_fixture="command_result",
)
def i_get_execution_history(started_execution, e2e_port):
    return runner.invoke(
        app,
        [
            "stepfunctions",
            "get-execution-history",
            "--execution-arn",
            started_execution["executionArn"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I list executions for state machine "{name}"'),
    target_fixture="command_result",
)
def i_list_executions(name, e2e_port):
    return runner.invoke(
        app,
        [
            "stepfunctions",
            "list-executions",
            "--name",
            name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I list state machine versions for "{name}"'),
    target_fixture="command_result",
)
def i_list_state_machine_versions(name, e2e_port):
    return runner.invoke(
        app,
        [
            "stepfunctions",
            "list-state-machine-versions",
            "--name",
            name,
            "--port",
            str(e2e_port),
        ],
    )


@when("I list state machines", target_fixture="command_result")
def i_list_state_machines(e2e_port):
    return runner.invoke(
        app,
        [
            "stepfunctions",
            "list-state-machines",
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I list tags for state machine "{name}"'),
    target_fixture="command_result",
)
def i_list_tags_for_state_machine(name, e2e_port):
    resource_arn = f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
    return runner.invoke(
        app,
        [
            "stepfunctions",
            "list-tags-for-resource",
            "--resource-arn",
            resource_arn,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse("I start an execution on state machine \"{name}\" with input '{input_json}'"),
    target_fixture="command_result",
)
def i_start_execution(name, input_json, e2e_port):
    return runner.invoke(
        app,
        [
            "stepfunctions",
            "start-execution",
            "--name",
            name,
            "--input",
            input_json,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I start a sync execution on state machine "{name}" with input "{input_json}"'),
    target_fixture="command_result",
)
def i_start_sync_execution(name, input_json, e2e_port):
    return runner.invoke(
        app,
        [
            "stepfunctions",
            "start-sync-execution",
            "--name",
            name,
            "--input",
            input_json,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I stop the started execution",
    target_fixture="command_result",
)
def i_stop_started_execution(started_execution, e2e_port):
    return runner.invoke(
        app,
        [
            "stepfunctions",
            "stop-execution",
            "--execution-arn",
            started_execution["executionArn"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I tag state machine "{name}" with tags {tags_json}'),
    target_fixture="command_result",
)
def i_tag_state_machine(name, tags_json, e2e_port):
    resource_arn = f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
    return runner.invoke(
        app,
        [
            "stepfunctions",
            "tag-resource",
            "--resource-arn",
            resource_arn,
            "--tags",
            tags_json,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I untag state machine "{name}" with tag keys {keys_json}'),
    target_fixture="command_result",
)
def i_untag_state_machine(name, keys_json, e2e_port):
    resource_arn = f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
    return runner.invoke(
        app,
        [
            "stepfunctions",
            "untag-resource",
            "--resource-arn",
            resource_arn,
            "--tag-keys",
            keys_json,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I update state machine "{name}" with an updated definition'),
    target_fixture="command_result",
)
def i_update_state_machine(name, e2e_port):
    return runner.invoke(
        app,
        [
            "stepfunctions",
            "update-state-machine",
            "--name",
            name,
            "--definition",
            UPDATED_DEFINITION,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I validate a Pass state machine definition",
    target_fixture="command_result",
)
def i_validate_state_machine_definition(e2e_port):
    return runner.invoke(
        app,
        [
            "stepfunctions",
            "validate-state-machine-definition",
            "--definition",
            PASS_DEFINITION,
            "--port",
            str(e2e_port),
        ],
    )


@given(
    parsers.parse('state machine "{name}" was tagged with tags {tags_json}'),
)
def state_machine_was_tagged(name, tags_json, lws_invoke, e2e_port):
    resource_arn = f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
    lws_invoke(
        [
            "stepfunctions",
            "tag-resource",
            "--resource-arn",
            resource_arn,
            "--tags",
            tags_json,
            "--port",
            str(e2e_port),
        ]
    )


@then(parsers.parse('state machine "{name}" will exist'))
def state_machine_will_exist(name, assert_invoke, e2e_port):
    verify = assert_invoke(
        ["stepfunctions", "describe-state-machine", "--name", name, "--port", str(e2e_port)]
    )
    actual_name = verify["name"]
    assert actual_name == name


@then(parsers.parse('state machine "{name}" will not appear in list-state-machines'))
def state_machine_will_not_appear(name, assert_invoke, e2e_port):
    verify = assert_invoke(["stepfunctions", "list-state-machines", "--port", str(e2e_port)])
    actual_names = [sm["name"] for sm in verify.get("stateMachines", [])]
    assert name not in actual_names


@then(parsers.parse("the executions list will have at least {count:d} entry"))
def the_executions_list_will_have_entries(count, command_result, parse_output):
    actual_executions = parse_output(command_result.output)["executions"]
    assert len(actual_executions) >= count


@then("the output will contain an execution ARN")
def the_output_will_contain_execution_arn(command_result, parse_output):
    data = parse_output(command_result.output)
    assert "executionArn" in data


@then(parsers.parse('the output will contain state machine name "{expected_name}"'))
def the_output_will_contain_state_machine_name(expected_name, command_result, parse_output):
    actual_name = parse_output(command_result.output)["name"]
    assert actual_name == expected_name


@then("the output will contain a status field")
def the_output_will_contain_status_field(command_result, parse_output):
    data = parse_output(command_result.output)
    assert "status" in data


@then("the output will contain the execution ARN")
def the_output_will_contain_the_execution_arn(command_result, parse_output, started_execution):
    actual_arn = parse_output(command_result.output)["executionArn"]
    expected_arn = started_execution["executionArn"]
    assert actual_arn == expected_arn


@then("the started execution will have a status")
def the_started_execution_will_have_status(command_result, parse_output, assert_invoke, e2e_port):
    data = parse_output(command_result.output)
    verify = assert_invoke(
        [
            "stepfunctions",
            "describe-execution",
            "--execution-arn",
            data["executionArn"],
            "--port",
            str(e2e_port),
        ]
    )
    assert "status" in verify


@then(parsers.parse('the state machine list will include "{expected_name}"'))
def the_state_machine_list_will_include(expected_name, command_result, parse_output):
    actual_names = [sm["name"] for sm in parse_output(command_result.output)["stateMachines"]]
    assert expected_name in actual_names


@then(parsers.parse('state machine "{name}" will have the updated definition'))
def state_machine_will_have_updated_definition(name, assert_invoke, e2e_port):
    verify = assert_invoke(
        ["stepfunctions", "describe-state-machine", "--name", name, "--port", str(e2e_port)]
    )
    actual_definition = json.loads(verify["definition"])
    expected_definition = json.loads(UPDATED_DEFINITION)
    assert actual_definition == expected_definition


@then(
    parsers.parse('state machine "{name}" will have tag "{key}" with value "{value}"'),
)
def state_machine_will_have_tag(name, key, value, assert_invoke, e2e_port):
    resource_arn = f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
    verify = assert_invoke(
        [
            "stepfunctions",
            "list-tags-for-resource",
            "--resource-arn",
            resource_arn,
            "--port",
            str(e2e_port),
        ]
    )
    tags = verify.get("tags", [])
    actual_value = next(
        (t["value"] for t in tags if t.get("key") == key),
        None,
    )
    assert actual_value == value


@then(
    parsers.parse('state machine "{name}" will not have tag "{key}"'),
)
def state_machine_will_not_have_tag(name, key, assert_invoke, e2e_port):
    resource_arn = f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
    verify = assert_invoke(
        [
            "stepfunctions",
            "list-tags-for-resource",
            "--resource-arn",
            resource_arn,
            "--port",
            str(e2e_port),
        ]
    )
    tags = verify.get("tags", [])
    actual_keys = [t["key"] for t in tags]
    assert key not in actual_keys


@then(
    parsers.parse('the stopped execution will have status "{expected_status}"'),
)
def the_stopped_execution_will_have_status(
    expected_status, started_execution, assert_invoke, e2e_port
):
    verify = assert_invoke(
        [
            "stepfunctions",
            "describe-execution",
            "--execution-arn",
            started_execution["executionArn"],
            "--port",
            str(e2e_port),
        ]
    )
    actual_status = verify["status"]
    assert actual_status == expected_status
