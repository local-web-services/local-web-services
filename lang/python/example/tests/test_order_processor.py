"""Tests for the order processor using local-web-services."""

import json
import pytest
from lws_testing import LwsSession
from src.order_processor import process_order

STATE_MACHINE_DEFINITION = {
    "Comment": "Simple order processor — passes input through as output",
    "StartAt": "ProcessOrder",
    "States": {
        "ProcessOrder": {
            "Type": "Pass",
            "End": True,
        }
    },
}


@pytest.fixture(scope="module")
def session():
    with LwsSession() as s:
        yield s


@pytest.fixture(scope="module")
def sfn_client(session):
    # session.client() returns a pre-configured client pointing at the local emulator
    return session.client("stepfunctions")


@pytest.fixture(scope="module")
def state_machine_arn(sfn_client):
    # Arrange — create the state machine in the local SFN emulator
    response = sfn_client.create_state_machine(
        name="OrderProcessor",
        definition=json.dumps(STATE_MACHINE_DEFINITION),
        roleArn="arn:aws:iam::000000000000:role/StepFunctionsRole",
        type="STANDARD",
    )
    return response["stateMachineArn"]


def test_process_order_returns_order_id(state_machine_arn, sfn_client):
    # Arrange
    expected_order_id = "order-123"

    # Act — pass the local SFN client so process_order hits the emulator
    actual_result = process_order(expected_order_id, state_machine_arn, sfn_client)

    # Assert
    assert actual_result["orderId"] == expected_order_id


def test_process_order_handles_multiple_orders(state_machine_arn, sfn_client):
    # Arrange
    expected_order_ids = ["order-1", "order-2", "order-3"]

    for expected_order_id in expected_order_ids:
        # Act
        actual_result = process_order(expected_order_id, state_machine_arn, sfn_client)

        # Assert
        assert actual_result["orderId"] == expected_order_id


FAKE_STATE_MACHINE_ARN = "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor"
FAKE_EXECUTION_ARN = "arn:aws:states:us-east-1:000000000000:execution:OrderProcessor:fake-exec"


def test_process_order_with_faked_success(session, sfn_client):
    # Arrange — fake both SFN calls so no real state machine is needed
    session.fake("stepfunctions").operation("start-execution").respond(
        body={
            "executionArn": FAKE_EXECUTION_ARN,
            "startDate": 1704067200.0,
        }
    )
    session.fake("stepfunctions").operation("describe-execution").respond(
        body={
            "executionArn": FAKE_EXECUTION_ARN,
            "stateMachineArn": FAKE_STATE_MACHINE_ARN,
            "name": "fake-exec",
            "status": "SUCCEEDED",
            "startDate": 1704067200.0,
            "output": json.dumps({"orderId": "order-fake"}),
        }
    )

    # Act
    actual_result = process_order("order-fake", FAKE_STATE_MACHINE_ARN, sfn_client)

    # Assert
    assert actual_result["orderId"] == "order-fake"

    # Cleanup — clear the fake so subsequent tests are unaffected
    session.fake("stepfunctions").clear()


def test_process_order_raises_when_execution_limit_exceeded(session, sfn_client):
    # Arrange — fake StartExecution to return an AWS error
    session.fake("stepfunctions").operation("start-execution").error(
        error_type="ExecutionLimitExceeded",
        message="You have exceeded the maximum number of running executions.",
    )

    # Act + Assert — production code should propagate the AWS error
    with pytest.raises(Exception) as exc_info:
        process_order("order-999", FAKE_STATE_MACHINE_ARN, sfn_client)

    assert "ExecutionLimitExceeded" in str(exc_info.value)

    # Cleanup — clear the fake so subsequent tests are unaffected
    session.fake("stepfunctions").clear()


def test_process_order_using_terraform_definition():
    # Arrange — start ldk from the Terraform config; it reads terraform/main.tf
    # and provisions the OrderProcessor state machine automatically
    with LwsSession.from_hcl("terraform") as tf_session:
        tf_sfn_client = tf_session.client("stepfunctions")
        expected_order_id = "order-tf"

        state_machines = tf_sfn_client.list_state_machines()["stateMachines"]
        state_machine_arn = state_machines[0]["stateMachineArn"]

        # Act
        actual_result = process_order(expected_order_id, state_machine_arn, tf_sfn_client)

    # Assert
    assert actual_result["orderId"] == expected_order_id
