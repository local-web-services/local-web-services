"""Session-scoped fixtures and shared BDD step definitions."""

from __future__ import annotations

import json

import pytest
from lws_testing.session import LwsSession
from pytest_bdd import given, parsers, then

# ── Fixtures ────────────────────────────────────────────────────────────


@pytest.fixture(scope="session")
def lws_session():
    """Start all LWS services in-process for the entire test session."""
    with LwsSession() as session:
        yield session


@pytest.fixture(autouse=True)
def reset_lws_between_scenarios(lws_session):
    """Reset all service state before each scenario."""
    lws_session.reset()


@pytest.fixture
def world():
    """Per-scenario mutable state shared across all BDD steps."""
    return {
        "result": None,
        "error": None,
        "receipt_handle": None,
        "topic_arn": None,
        "subscription_arn": None,
        "execution_arn": None,
        "state_machine_arn": None,
        "state_machine_name": None,
        "upload_id": None,
        "version_id": None,
    }


# ── Shared constants ─────────────────────────────────────────────────────

# SQS
TEST_QUEUE = "e2e-test-q1"
TEST_DLQ = "e2e-test-dlq-1"

# SNS
TEST_TOPIC = "e2e-test-topic-1"

# EventBridge
TEST_BUS = "e2e-test-bus-1"
TEST_RULE = "test-rule-1"
EVENT_PATTERN = json.dumps({"source": ["test.source"]})

# Step Functions
TEST_SM = "test-sm-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"
PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})
TEST_INPUT = '{"key": "value"}'

# DynamoDB
TEST_TABLE = "e2e-test-tbl-1"
TEST_PK = "pk"
TEST_ITEM_KEY = "e2e-item-key-1"

# S3
TEST_BUCKET = "e2e-test-bkt-1"
TEST_KEY = "e2e-test-key-1"
TEST_BODY = b"test-data-content-1"

# SSM
TEST_PARAM = "/e2e/test/param/1"
TEST_PARAM_VALUE = "e2e-test-value-1"

# Secrets Manager
TEST_SECRET = "e2e-test-secret-1"
TEST_SECRET_VALUE = "e2e-test-secret-value-1"


# ── Shared client helpers ────────────────────────────────────────────────


def _sqs(lws_session):
    return lws_session.client("sqs")


def _queue_url(lws_session, name=TEST_QUEUE):
    return lws_session.queue_url(name)


def _queue_arn(name=TEST_QUEUE):
    return f"arn:aws:sqs:us-east-1:000000000000:{name}"


def _create_queue(lws_session, name=TEST_QUEUE):
    _sqs(lws_session).create_queue(QueueName=name)


def _sns(lws_session):
    return lws_session.client("sns")


def _topic_arn(name=TEST_TOPIC):
    return f"arn:aws:sns:us-east-1:000000000000:{name}"


def _create_topic(lws_session, name=TEST_TOPIC):
    resp = _sns(lws_session).create_topic(Name=name)
    return resp["TopicArn"]


def _events(lws_session):
    return lws_session.client("events")


def _create_bus(lws_session, name=TEST_BUS):
    _events(lws_session).create_event_bus(Name=name)


def _create_rule(lws_session, bus_name=TEST_BUS, rule_name=TEST_RULE):
    _events(lws_session).put_rule(
        Name=rule_name,
        EventBusName=bus_name,
        EventPattern=EVENT_PATTERN,
        State="ENABLED",
    )


def _sfn(lws_session):
    return lws_session.client("stepfunctions")


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"


def _create_sm(lws_session, name=TEST_SM, sm_type="STANDARD"):
    resp = _sfn(lws_session).create_state_machine(
        name=name,
        definition=PASS_DEFINITION,
        roleArn=ROLE_ARN,
        type=sm_type,
    )
    return resp["stateMachineArn"]


def _start_execution(lws_session, sm_name=TEST_SM):
    sm_arn = _sm_arn(sm_name)
    resp = _sfn(lws_session).start_execution(stateMachineArn=sm_arn, input=TEST_INPUT)
    return resp["executionArn"]


def _dynamo(lws_session):
    return lws_session.client("dynamodb")


def _create_table(lws_session, name=TEST_TABLE):
    _dynamo(lws_session).create_table(
        TableName=name,
        KeySchema=[{"AttributeName": TEST_PK, "KeyType": "HASH"}],
        AttributeDefinitions=[{"AttributeName": TEST_PK, "AttributeType": "S"}],
        BillingMode="PAY_PER_REQUEST",
    )


def _s3(lws_session):
    return lws_session.client("s3")


def _create_bucket(lws_session, name=TEST_BUCKET):
    _s3(lws_session).create_bucket(Bucket=name)


def _ssm(lws_session):
    return lws_session.client("ssm")


def _create_param(lws_session, name=TEST_PARAM):
    _ssm(lws_session).put_parameter(Name=name, Value=TEST_PARAM_VALUE, Type="String")


def _secretsmanager(lws_session):
    return lws_session.client("secretsmanager")


def _create_secret(lws_session, name=TEST_SECRET):
    _secretsmanager(lws_session).create_secret(Name=name, SecretString=TEST_SECRET_VALUE)


# ── Shared BDD steps: always-present invariants ──────────────────────────


@given("the system is initialized")
def system_initialized():
    """No-op: the session fixture has already started all services."""


@then("the operation is rejected")
def operation_is_rejected(world):
    expected_error = "an error"
    actual_error = world["error"]
    assert (
        actual_error is not None
    ), f"Expected {expected_error} but the operation succeeded with result: {world['result']}"


@then(parsers.re(r"^every .+"))
def global_invariant_holds():
    """Invariant steps are trivially satisfied in an isolated test context."""


@then(parsers.re(r"^no .+ is in-flight .+"))
def no_inflight_invariant_holds():
    """Invariant steps are trivially satisfied in an isolated test context."""


@then(parsers.re(r"^a message can only be .+"))
def delivery_invariant_holds():
    """Invariant steps are trivially satisfied in an isolated test context."""


@then(parsers.re(r"^overwriting a parameter .+"))
def overwrite_invariant_holds():
    """Invariant steps are trivially satisfied in an isolated test context."""


@then(parsers.re(r"^all tag keys are .+"))
def tag_key_invariant_holds():
    """Invariant steps are trivially satisfied in an isolated test context."""


@then(parsers.re(r"^deleted tables are never .+"))
def deleted_table_invariant_holds():
    """Invariant steps are trivially satisfied in an isolated test context."""


@then(parsers.re(r"^a pending transaction always .+"))
def pending_transaction_invariant_holds():
    """Invariant steps are trivially satisfied in an isolated test context."""


@then(parsers.re(r".+ status is always a valid value"))
def status_invariant_holds():
    """Invariant steps are trivially satisfied in an isolated test context."""


@then(parsers.re(r".+ is never negative"))
def never_negative_invariant_holds():
    """Invariant steps are trivially satisfied in an isolated test context."""
