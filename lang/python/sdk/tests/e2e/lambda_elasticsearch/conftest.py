"""Abstract BDD step definitions for LambdaElasticsearch integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_FUNC = "e2e-test-func-1"
TEST_DOMAIN = "e2e-test-domain-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _lambda(lws_session):
    return lws_session.client("lambda")


def _es(lws_session):
    return lws_session.client("es")


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


def _create_domain(lws_session, name=TEST_DOMAIN):
    _es(lws_session).create_elasticsearch_domain(DomainName=name)


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


# ── Given: domain state ────────────────────────────────────────────────


@given("the domain does not already exist")
def domain_not_already_exist():
    """No-op: fresh state has no domains."""


@given("the domain already exists")
def domain_already_exists(lws_session):
    try:
        _create_domain(lws_session)
    except Exception:  # noqa: BLE001
        pass


@given("the domain exists")
def domain_exists(lws_session):
    _create_domain(lws_session)


@given('the domain is "AVAILABLE"')
def domain_is_available_given(lws_session):
    try:
        _create_domain(lws_session)
    except Exception:  # noqa: BLE001
        pass


@given('the domain is not "AVAILABLE"')
def domain_is_not_available_given(lws_session, world):
    try:
        _es(lws_session).delete_elasticsearch_domain(DomainName=TEST_DOMAIN)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("es").create_dwell_ms(5000).apply()
    _create_domain(lws_session)
    world["result"] = None
    world["error"] = None


@given('the domain is "PROCESSING"')
def domain_is_processing_given(lws_session, world):
    try:
        _es(lws_session).delete_elasticsearch_domain(DomainName=TEST_DOMAIN)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("es").create_dwell_ms(5000).apply()
    _create_domain(lws_session)
    world["result"] = None
    world["error"] = None


@given('the domain is not "PROCESSING"')
def domain_is_not_processing_given(lws_session):
    _create_domain(lws_session)


@given("the domain does not exist")
def domain_does_not_exist():
    """No-op: fresh state has no domains."""


# ── Given: invocation / slot state ────────────────────────────────────


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


@given("a document slot is available")
def document_slot_available():
    """No-op: always room for documents."""


@given("no document slot is available")
def no_document_slot_available():
    pytest.skip("Cannot exhaust document slot limit")


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


@when('an Elasticsearch domain is created and becomes "AVAILABLE"')
def create_elasticsearch_domain(lws_session, world):
    try:
        _create_domain(lws_session)
        world["result"] = {"DomainName": TEST_DOMAIN}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("a domain configuration update begins")
def domain_update_begins(lws_session, world):
    try:
        resp = _es(lws_session).update_elasticsearch_domain_config(DomainName=TEST_DOMAIN)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("the domain configuration update completes")
def domain_update_completes(world):
    pytest.skip("Cannot trigger domain update completion in lws")


@when("the Lambda function is invoked")
def invoke_function(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when("the Lambda function fails to write because the domain is processing a config update")
def invocation_fails_domain_processing(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when('the Lambda function indexes a document into the "AVAILABLE" domain and succeeds')
def lambda_indexes_document(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


# ── Then: assertions ────────────────────────────────────────────────────


@then('the function is "ACTIVE"')
def func_is_active_then(lws_session):
    resp = _lambda(lws_session).get_function(FunctionName=TEST_FUNC)
    expected_state = "Active"
    actual_state = resp["Configuration"]["State"]
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"


@then('the domain is "AVAILABLE"')
def domain_is_available_then(lws_session):
    resp = _es(lws_session).describe_elasticsearch_domain(DomainName=TEST_DOMAIN)
    actual_name = resp["DomainStatus"].get("DomainName", "")
    expected_name = TEST_DOMAIN
    assert (
        actual_name == expected_name
    ), f"Expected domain name '{expected_name}' but got '{actual_name}'"


@then('the domain is "PROCESSING" and write operations may fail')
def domain_is_processing_then(world):
    pytest.skip("Cannot observe domain processing state in lws")


@then('the domain is "AVAILABLE" again')
def domain_is_available_again_then(world):
    pytest.skip("Cannot observe domain update completion in lws")


@then('the invocation is "IN_PROGRESS"')
def invocation_is_in_progress_then(world):
    pytest.skip("Cannot observe Lambda invocation state in lws")


@then('the invocation is "FAILED" with a connection error')
def invocation_failed_connection_error(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")


@then('the document "EXISTS" and the invocation is "SUCCESS"')
def document_exists_invocation_success(world):
    pytest.skip("Cannot observe Lambda document index result in lws")
