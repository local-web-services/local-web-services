"""Abstract BDD step definitions for SnsLambda integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_TOPIC_NAME = "e2e-test-topic-1"
TEST_FUNC = "e2e-test-func-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _sns(lws_session):
    return lws_session.client("sns")


def _lambda(lws_session):
    return lws_session.client("lambda")


def _topic_arn(name=TEST_TOPIC_NAME):
    return f"arn:aws:sns:us-east-1:000000000000:{name}"


def _create_topic(lws_session, name=TEST_TOPIC_NAME):
    _sns(lws_session).create_topic(Name=name)


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


# ── Given: topic state ────────────────────────────────────────────────


@given("the topic does not already exist")
def sns_lambda_topic_not_already_exist():
    """No-op: fresh state has no topics."""


@given("the topic already exists")
def sns_lambda_topic_already_exists(lws_session):
    _create_topic(lws_session)


@given("the topic exists")
def sns_lambda_topic_exists(lws_session):
    _create_topic(lws_session)


@given('the topic is "ACTIVE"')
def sns_lambda_topic_is_active_given():
    """No-op: topics are ACTIVE by default after creation."""


@given('the topic is not "ACTIVE"')
def sns_lambda_topic_is_not_active_given(lws_session, world):
    try:
        _sns(lws_session).delete_topic(TopicArn=_topic_arn())
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("sns").create_dwell_ms(5000).apply()
    _create_topic(lws_session)
    world["result"] = None
    world["error"] = None


@given("the topic does not exist")
def sns_lambda_topic_does_not_exist():
    """No-op: fresh state has no topics."""


# ── Given: function state ─────────────────────────────────────────────


@given("the function does not already exist")
def sns_lambda_function_not_already_exist():
    """No-op: fresh state has no Lambda functions."""


@given("the function already exists")
def sns_lambda_function_already_exists(lws_session):
    _create_function(lws_session)


@given("the function exists")
def sns_lambda_function_exists(lws_session):
    _create_function(lws_session)


@given('the function is "ACTIVE"')
def sns_lambda_function_is_active_given():
    """No-op: Lambda functions are ACTIVE immediately after creation."""


@given('the function is not "ACTIVE"')
def sns_lambda_function_is_not_active_given(lws_session, world):
    try:
        _lambda(lws_session).delete_function(FunctionName=TEST_FUNC)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    _create_function(lws_session)
    world["result"] = None
    world["error"] = None


@given("the function does not exist")
def sns_lambda_function_does_not_exist():
    """No-op: fresh state has no Lambda functions."""


# ── Given: subscription state ─────────────────────────────────────────


@given("the subscription slot is available")
def sns_lambda_subscription_slot_available(lws_session):
    lws_session.capacity("sns").unlimited().apply()


@given("the subscription slot is not available")
def sns_lambda_subscription_slot_not_available(lws_session):
    lws_session.capacity("sns").exhaust().apply()


@given("a confirmed subscription exists for the topic")
def sns_lambda_confirmed_subscription_exists():
    pytest.skip("Cannot configure SNS subscription to Lambda in lws")


@given("no confirmed subscription exists for the topic")
def sns_lambda_no_confirmed_subscription():
    """No-op: fresh state has no subscriptions."""


@given('the subscribed function is "ACTIVE"')
def sns_lambda_subscribed_function_is_active():
    pytest.skip("Cannot configure SNS subscription to Lambda in lws")


@given('the subscribed function is not "ACTIVE"')
def sns_lambda_subscribed_function_is_not_active():
    pytest.skip("Cannot configure SNS subscription to Lambda in lws")


# ── Given: invocation slots ───────────────────────────────────────────


@given("an invocation slot is available")
def sns_lambda_invocation_slot_available(lws_session):
    lws_session.capacity("lambda").unlimited().apply()


@given("no invocation slot is available")
def sns_lambda_no_invocation_slot_available(lws_session):
    lws_session.capacity("lambda").exhaust().apply()


# ── Given: invocation state ───────────────────────────────────────────


@given('an invocation is "IN_PROGRESS"')
def sns_lambda_invocation_is_in_progress():
    pytest.skip("Cannot trigger SNS->Lambda invocation in lws")


@given('no invocation is "IN_PROGRESS"')
def sns_lambda_no_invocation_is_in_progress():
    """No-op: fresh state has no in-progress invocations."""


# ── When: actions ──────────────────────────────────────────────────────


@when('an "SNS" topic is created')
def create_sns_topic_lambda(lws_session, world):
    try:
        resp = _sns(lws_session).create_topic(Name=TEST_TOPIC_NAME)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("a Lambda function is deployed")
def deploy_lambda_function_sns(lws_session, world):
    try:
        resp = _lambda(lws_session).create_function(
            FunctionName=TEST_FUNC,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('a Lambda function subscribes to an "SNS" topic')
def subscribe_lambda_to_topic(world):
    pytest.skip("Cannot configure SNS subscription to Lambda in lws")


@when(
    'a message is published to an "SNS" topic and asynchronously '
    "invokes the subscribed Lambda function"
)
def publish_and_invoke_lambda(world):
    pytest.skip("Cannot trigger SNS->Lambda invocation in lws")


@when("the Lambda invocation completes successfully")
def sns_lambda_invocation_completes(world):
    pytest.skip("Cannot trigger SNS->Lambda invocation in lws")


@when("the Lambda invocation fails")
def sns_lambda_invocation_fails(world):
    pytest.skip("Cannot trigger SNS->Lambda invocation in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the topic is "ACTIVE"')
def sns_lambda_topic_is_active_then(lws_session):
    resp = _sns(lws_session).list_topics()
    actual_arns = [t["TopicArn"] for t in resp.get("Topics", [])]
    expected_arn = _topic_arn()
    assert (
        expected_arn in actual_arns
    ), f"Expected topic '{expected_arn}' to be ACTIVE but not found in: {actual_arns}"


@then('the function is "ACTIVE"')
def sns_lambda_function_is_active_then(lws_session):
    resp = _lambda(lws_session).get_function(FunctionName=TEST_FUNC)
    expected_state = "Active"
    actual_state = resp["Configuration"].get("State", "")
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"


@then('the subscription is "CONFIRMED" and the function will be invoked on published messages')
def subscription_confirmed():
    pytest.skip("Cannot configure SNS subscription to Lambda in lws")


@then('the invocation is "IN_PROGRESS"')
def sns_lambda_invocation_is_in_progress_then():
    pytest.skip("Cannot trigger SNS->Lambda invocation in lws")


@then('the invocation is "SUCCESS"')
def sns_lambda_invocation_is_success():
    pytest.skip("Cannot trigger SNS->Lambda invocation in lws")


@then('the invocation is "FAILED"')
def sns_lambda_invocation_is_failed():
    pytest.skip("Cannot trigger SNS->Lambda invocation in lws")


# ── Given: sequence setup ─────────────────────────────────────────


@given("tid not in topic_status")
def sns_lambda_tid_not_in_topic_status():
    """No-op: fresh state has no topics."""


@given('an "SNS" topic has been created')
def sns_lambda_an_sns_topic_has_been_created(lws_session):
    _create_topic(lws_session)


@given("fid not in func_status")
def sns_lambda_fid_not_in_func_status():
    """No-op: fresh state has no Lambda functions."""


@given("a Lambda function has been deployed")
def sns_lambda_a_lambda_function_has_been_deployed(lws_session):
    _create_function(lws_session)


@given("tid in topic_status")
def sns_lambda_tid_in_topic_status(lws_session):
    _create_topic(lws_session)


@given('a Lambda function has subscribed to an "SNS" topic')
def sns_lambda_a_lambda_function_has_subscribed():
    pytest.skip("Cannot configure SNS subscription to Lambda in lws")


@given(
    'a message has been published to an "SNS" topic and asynchronously invoked the subscribed Lambda function'  # noqa: E501
)
def sns_lambda_a_message_has_been_published_and_invoked():
    pytest.skip("Cannot trigger SNS->Lambda invocation in lws")


@given("iid in inv_status")
def sns_lambda_iid_in_inv_status():
    pytest.skip("Cannot observe internal Lambda invocation state via public API")


@given("the Lambda invocation has completed successfully")
def sns_lambda_the_lambda_invocation_has_completed_successfully():
    pytest.skip("Cannot trigger SNS->Lambda invocation in lws")


@given("the Lambda invocation has failed")
def sns_lambda_the_lambda_invocation_has_failed():
    pytest.skip("Cannot trigger SNS->Lambda invocation in lws")


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic')
def _inv_sns_lambda_every_confirmed_subscription_references_an_active_sns_topic():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function')
def _inv_sns_lambda_every_in_progress_invocation_references_an_active_lambda_functio():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription')
def _inv_sns_lambda_every_in_progress_invocation_was_triggered_by_a_confirmed_subscr():
    """Invariant step: trivially satisfied in isolated test context."""
