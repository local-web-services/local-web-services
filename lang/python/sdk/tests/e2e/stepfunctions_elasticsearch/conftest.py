"""Abstract BDD step definitions for StepfunctionsElasticsearch integration spec scenarios."""

from __future__ import annotations

import json

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_SM = "test-sm-1"
TEST_DOMAIN = "e2e-test-domain-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"
PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})
TEST_INPUT = '{"key": "value"}'


def _sfn(lws_session):
    return lws_session.client("stepfunctions")


def _es(lws_session):
    return lws_session.client("es")


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"


def _create_sm(lws_session, name=TEST_SM):
    resp = _sfn(lws_session).create_state_machine(
        name=name,
        definition=PASS_DEFINITION,
        roleArn=ROLE_ARN,
    )
    return resp["stateMachineArn"]


def _create_domain(lws_session, name=TEST_DOMAIN):
    _es(lws_session).create_elasticsearch_domain(DomainName=name)


def _start_execution(lws_session, name=TEST_SM):
    resp = _sfn(lws_session).start_execution(
        stateMachineArn=_sm_arn(name),
        input=TEST_INPUT,
    )
    return resp["executionArn"]


# ── Given: state machine state ────────────────────────────────────────


@given("the state machine does not already exist")
def sm_not_already_exist():
    """No-op: fresh state has no state machines."""


@given("the state machine already exists")
def sm_already_exists(lws_session):
    _create_sm(lws_session)


@given("the state machine exists")
def sm_exists(lws_session):
    _create_sm(lws_session)


@given('the state machine is "ACTIVE"')
def sm_is_active_given():
    """No-op: state machines are ACTIVE immediately after creation."""


@given('the state machine is not "ACTIVE"')
def sm_is_not_active_given(lws_session, world):
    try:
        _sfn(lws_session).delete_state_machine(stateMachineArn=_sm_arn())
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("stepfunctions").create_dwell_ms(5000).apply()
    _create_sm(lws_session)
    world["result"] = None
    world["error"] = None


@given("the state machine does not exist")
def sm_does_not_exist():
    """No-op: fresh state has no state machines."""


# ── Given: domain state ───────────────────────────────────────────────


@given("the domain does not already exist")
def domain_not_already_exist():
    """No-op: fresh state has no Elasticsearch domains."""


@given("the domain already exists")
def domain_already_exists(lws_session):
    _create_domain(lws_session)


@given("the domain exists")
def domain_exists(lws_session):
    _create_domain(lws_session)


@given('the domain is "AVAILABLE"')
def domain_is_available_given():
    """No-op: Elasticsearch domains are AVAILABLE immediately after creation."""


@given("the domain does not exist")
def domain_does_not_exist():
    """No-op: fresh state has no Elasticsearch domains."""


@given('the domain is "PROCESSING"')
def domain_is_processing_given(lws_session, world):
    pytest.skip("Cannot put an Elasticsearch domain into PROCESSING state in lws")


@given('the domain is not "PROCESSING"')
def domain_is_not_processing_given(lws_session):
    _create_domain(lws_session)


@given('the domain is not "AVAILABLE"')
def domain_is_not_available_given():
    pytest.skip("lws does not support non-AVAILABLE Elasticsearch domain lifecycle states")


# ── Given: execution state ────────────────────────────────────────────


@given('an execution is "RUNNING"')
def execution_is_running_given(lws_session):
    _create_sm(lws_session)
    _start_execution(lws_session)


@given('no execution is "RUNNING"')
def no_execution_is_running():
    """No-op: fresh state has no executions."""


# ── Given: slots ───────────────────────────────────────────────────────


@given("an execution slot is available")
def execution_slot_available():
    """No-op: always room for executions."""


@given("no execution slot is available")
def no_execution_slot_available():
    pytest.skip("Cannot exhaust execution slot limit")


# ── When: actions ──────────────────────────────────────────────────────


@when("a Step Functions state machine is created")
def create_state_machine(lws_session, world):
    try:
        resp = _sfn(lws_session).create_state_machine(
            name=TEST_SM,
            definition=PASS_DEFINITION,
            roleArn=ROLE_ARN,
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('an Elasticsearch domain is created and becomes "AVAILABLE"')
def create_elasticsearch_domain(lws_session, world):
    try:
        resp = _es(lws_session).create_elasticsearch_domain(DomainName=TEST_DOMAIN)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a domain configuration update begins")
def domain_configuration_update_begins(lws_session, world):
    pytest.skip("Cannot trigger internal Elasticsearch domain configuration update in lws")


@when("the domain configuration update completes")
def domain_configuration_update_completes(world):
    pytest.skip(
        "Cannot trigger internal Elasticsearch domain configuration update completion in lws"
    )


@when("an execution of the state machine is started")
def start_execution(lws_session, world):
    try:
        resp = _sfn(lws_session).start_execution(
            stateMachineArn=_sm_arn(),
            input=TEST_INPUT,
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('a running execution calls an "AVAILABLE" Elasticsearch domain and the task succeeds')
def execution_calls_available_domain_succeeds(world):
    pytest.skip("Cannot trigger internal execution step that calls Elasticsearch in lws")


@when("a running execution fails because the domain is processing a config update")
def execution_fails_domain_processing(world):
    pytest.skip(
        "Cannot trigger internal execution step that fails due to Elasticsearch domain processing in lws"
    )


# ── Then: assertions ───────────────────────────────────────────────────


@then('the state machine is "ACTIVE"')
def sm_is_active_then(lws_session):
    resp = _sfn(lws_session).describe_state_machine(stateMachineArn=_sm_arn())
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected state machine status '{expected_status}' but got '{actual_status}'"


@then('the domain is "AVAILABLE"')
def domain_is_available_then(lws_session):
    resp = _es(lws_session).describe_elasticsearch_domain(DomainName=TEST_DOMAIN)
    expected_processing = False
    actual_processing = resp["DomainStatus"]["Processing"]
    assert (
        actual_processing == expected_processing
    ), f"Expected domain Processing='{expected_processing}' but got '{actual_processing}'"


@then('the domain is "PROCESSING" and "API" calls may fail')
def domain_is_processing_then(lws_session):
    pytest.skip("Cannot observe Elasticsearch domain PROCESSING state in lws")


@then('the domain is "AVAILABLE" again')
def domain_is_available_again_then(lws_session):
    resp = _es(lws_session).describe_elasticsearch_domain(DomainName=TEST_DOMAIN)
    expected_processing = False
    actual_processing = resp["DomainStatus"]["Processing"]
    assert (
        actual_processing == expected_processing
    ), f"Expected domain Processing='{expected_processing}' but got '{actual_processing}'"


@then('the execution is "RUNNING"')
def execution_is_running_then(world):
    assert world["error"] is None, f"Expected start_execution to succeed but got: {world['error']}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"


@then('the execution is "SUCCEEDED"')
def execution_is_succeeded_then():
    pytest.skip("Cannot observe internal execution Elasticsearch task success in lws")


@then('the execution is "FAILED" with a connection error')
def execution_failed_connection_error():
    pytest.skip("Cannot observe internal execution Elasticsearch task failure in lws")
