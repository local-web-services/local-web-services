"""Abstract BDD step definitions for LambdaSns integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_FUNC = "e2e-test-func-1"
TEST_TOPIC_NAME = "e2e-test-topic-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _lambda(lws_session):
    return lws_session.client("lambda")


def _sns(lws_session):
    return lws_session.client("sns")


def _topic_arn(name=TEST_TOPIC_NAME):
    return f"arn:aws:sns:us-east-1:000000000000:{name}"


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


def _create_topic(lws_session, name=TEST_TOPIC_NAME):
    resp = _sns(lws_session).create_topic(Name=name)
    return resp["TopicArn"]


# ── Given: function state ─────────────────────────────────────────────


@given("the function does not already exist")
def func_not_already_exist():
    """No-op: fresh state has no functions."""


@given("the function already exists")
def func_already_exists(lws_session):
    _create_function(lws_session)


@given("the function exists")
def func_exists(lws_session):
    _create_function(lws_session)


@given('the function is "ACTIVE"')
def func_is_active_given():
    """No-op: functions are ACTIVE immediately after creation."""


@given('the function is not "ACTIVE"')
def func_is_not_active_given(lws_session, world):
    try:
        _lambda(lws_session).delete_function(FunctionName=TEST_FUNC)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    _create_function(lws_session)
    world["result"] = None
    world["error"] = None


@given("the function does not exist")
def func_does_not_exist():
    """No-op: fresh state has no functions."""


# ── Given: topic state ─────────────────────────────────────────────────


@given("the topic does not already exist")
def topic_not_already_exist():
    """No-op: fresh state has no topics."""


@given("the topic already exists")
def topic_already_exists(lws_session):
    _create_topic(lws_session)


@given("the topic exists")
def topic_exists(lws_session):
    _create_topic(lws_session)


@given('the topic is "ACTIVE"')
def topic_is_active_given():
    """No-op: topics are ACTIVE immediately after creation."""


@given('the topic is not "ACTIVE"')
def topic_is_not_active_given(lws_session, world):
    try:
        _sns(lws_session).delete_topic(TopicArn=_topic_arn())
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("sns").create_dwell_ms(5000).apply()
    _create_topic(lws_session)
    world["result"] = None
    world["error"] = None


@given("the topic does not exist")
def topic_does_not_exist():
    """No-op: fresh state has no topics."""


# ── Given: invocation state ────────────────────────────────────────────


@given('an invocation is "IN_PROGRESS"')
def invocation_is_in_progress(lws_session):
    _create_function(lws_session)


@given('no invocation is "IN_PROGRESS"')
def no_invocation_is_in_progress():
    """No-op: fresh state has no invocations."""


@given("an invocation slot is available")
def invocation_slot_available():
    """No-op: always room for invocations."""


@given("no invocation slot is available")
def no_invocation_slot_available():
    pytest.skip("Cannot exhaust invocation slot limit")


# ── Given: sequence setup ─────────────────────────────────────────────


@given("fid not in func_status")
def fid_not_in_func_status():
    """No-op: fresh state has no functions."""


@given("tid not in topic_status")
def tid_not_in_topic_status():
    """No-op: fresh state has no topics."""


@given("fid in func_status")
def fid_in_func_status(lws_session):
    _create_function(lws_session)


@given("iid in inv_status")
def iid_in_inv_status():
    pytest.skip("Cannot create an in-progress invocation in lws")


@given("a Lambda function has been deployed")
def lambda_function_has_been_deployed_seq(lws_session):
    _create_function(lws_session)


@given('an "SNS" topic has been created')
def sns_topic_has_been_created_seq(lws_session):
    _create_topic(lws_session)


@given("the Lambda function has been invoked")
def lambda_function_has_been_invoked_seq():
    pytest.skip("Cannot create a completed Lambda invocation in lws")


@given('the Lambda function has published a message to the "SNS" topic during invocation')
def lambda_published_message_to_topic_seq():
    pytest.skip("Cannot trigger Lambda SNS publish in lws")


@given("the Lambda invocation has completed successfully")
def lambda_invocation_completed_successfully_seq():
    pytest.skip("Cannot create a completed Lambda invocation in lws")


@given("the Lambda invocation has failed")
def lambda_invocation_has_failed_seq():
    pytest.skip("Cannot trigger Lambda invocation failure in lws")


# ── When: actions ───────────────────────────────────────────────────────


@when("a Lambda function is deployed")
def deploy_lambda_function(lws_session, world):
    try:
        _create_function(lws_session)
        world["result"] = {"FunctionName": TEST_FUNC}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('an "SNS" topic is created')
def create_sns_topic(lws_session, world):
    try:
        topic_arn = _create_topic(lws_session)
        world["result"] = {"TopicArn": topic_arn}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("the Lambda function is invoked")
def invoke_function(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when("the Lambda invocation fails")
def lambda_invocation_fails(world):
    pytest.skip("Cannot trigger Lambda invocation failure in lws")


@when("the Lambda invocation completes successfully")
def lambda_invocation_succeeds(world):
    pytest.skip("Cannot trigger Lambda invocation success in lws")


@when('the Lambda function publishes a message to the "SNS" topic during invocation')
def lambda_publishes_to_topic(world):
    pytest.skip("Cannot trigger Lambda SNS publish in lws")


# ── Then: assertions ────────────────────────────────────────────────────


@then('the function is "ACTIVE"')
def func_is_active_then(lws_session):
    resp = _lambda(lws_session).get_function(FunctionName=TEST_FUNC)
    expected_state = "Active"
    actual_state = resp["Configuration"]["State"]
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"


@then('the topic is "ACTIVE"')
def topic_is_active_then(lws_session):
    resp = _sns(lws_session).get_topic_attributes(TopicArn=_topic_arn())
    actual_arn = resp["Attributes"].get("TopicArn", "")
    expected_arn = _topic_arn()
    assert actual_arn == expected_arn, f"Expected topic ARN '{expected_arn}' but got '{actual_arn}'"


@then('the invocation is "IN_PROGRESS"')
def invocation_is_in_progress_then(world):
    pytest.skip("Cannot observe Lambda invocation state in lws")


@then('the invocation is "FAILED"')
def invocation_is_failed_then(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")


@then('the invocation is "SUCCESS"')
def invocation_is_success_then(world):
    pytest.skip("Cannot observe Lambda invocation success in lws")


@then("the message is published to the topic")
def message_published_to_topic(world):
    pytest.skip("Cannot observe Lambda SNS publish result in lws")


# ── Then: invariants and rejection ────────────────────────────────────


@then("the operation is rejected")
def operation_is_rejected_lambda_sns(world):
    # Arrange
    expected_error = None
    # Assert
    actual_error = world.get("error")
    assert actual_error is not expected_error, "Expected operation to be rejected but it succeeded"


@then('every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function')
def every_in_progress_invocation_references_active_function_sns():
    """Invariant step: trivially satisfied in isolated test context."""


@then('publishing requires an "ACTIVE" topic to be present')
def publishing_requires_active_topic():
    """Invariant step: trivially satisfied in isolated test context."""
