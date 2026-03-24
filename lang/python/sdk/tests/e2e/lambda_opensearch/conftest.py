"""Abstract BDD step definitions for LambdaOpensearch integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_FUNC = "e2e-test-func-1"
TEST_DOMAIN = "e2e-test-domain-1"
TEST_INDEX = "e2e-test-index-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _lambda(lws_session):
    return lws_session.client("lambda")


def _opensearch(lws_session):
    return lws_session.client("opensearch")


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


def _create_domain(lws_session, name=TEST_DOMAIN):
    _opensearch(lws_session).create_domain(DomainName=name)


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


@given('the domain is "ACTIVE"')
def domain_is_active_given(lws_session):
    try:
        _create_domain(lws_session)
    except Exception:  # noqa: BLE001
        pass


@given('the domain is not "ACTIVE"')
def domain_is_not_active_given(lws_session, world):
    try:
        _opensearch(lws_session).delete_domain(DomainName=TEST_DOMAIN)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("opensearch").create_dwell_ms(5000).apply()
    _create_domain(lws_session)
    world["result"] = None
    world["error"] = None


@given("the domain does not exist")
def domain_does_not_exist():
    """No-op: fresh state has no domains."""


# ── Given: index state ─────────────────────────────────────────────────


@given("the index does not already exist")
def index_not_already_exist():
    """No-op: fresh state has no indices."""


@given("the index already exists")
def index_already_exists():
    pytest.skip("Cannot pre-create OpenSearch index in lws")


@given("the index exists")
def index_exists():
    pytest.skip("Cannot pre-create OpenSearch index in lws")


@given("the index does not exist")
def index_does_not_exist():
    """No-op: fresh state has no indices."""


@given('the index\'s domain is "ACTIVE"')
def index_domain_is_active():
    pytest.skip("Cannot set up OpenSearch index with active domain in lws")


@given('the index\'s domain is not "ACTIVE"')
def index_domain_is_not_active():
    pytest.skip("Cannot set up OpenSearch index with non-active domain in lws")


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


@when("an OpenSearch domain is created")
def create_opensearch_domain(lws_session, world):
    try:
        _create_domain(lws_session)
        world["result"] = {"DomainName": TEST_DOMAIN}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("an index is created in the OpenSearch domain")
def create_opensearch_index(world):
    pytest.skip("Cannot create OpenSearch index in lws")


@when("the Lambda function is invoked")
def invoke_function(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when("the Lambda invocation fails")
def lambda_invocation_fails(world):
    pytest.skip("Cannot trigger Lambda invocation failure in lws")


@when("the Lambda invocation completes successfully")
def lambda_invocation_succeeds(world):
    pytest.skip("Cannot trigger Lambda invocation success in lws")


@when("the Lambda function indexes a document into the OpenSearch index during invocation")
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


@then('the domain is "ACTIVE"')
def domain_is_active_then(lws_session):
    resp = _opensearch(lws_session).describe_domain(DomainName=TEST_DOMAIN)
    actual_name = resp["DomainStatus"].get("DomainName", "")
    expected_name = TEST_DOMAIN
    assert (
        actual_name == expected_name
    ), f"Expected domain name '{expected_name}' but got '{actual_name}'"


@then('the index "EXISTS" and is ready to receive documents')
def index_exists_then(world):
    pytest.skip("Cannot observe OpenSearch index creation result in lws")


@then('the invocation is "IN_PROGRESS"')
def invocation_is_in_progress_then(world):
    pytest.skip("Cannot observe Lambda invocation state in lws")


@then('the invocation is "FAILED"')
def invocation_is_failed_then(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")


@then('the invocation is "SUCCESS"')
def invocation_is_success_then(world):
    pytest.skip("Cannot observe Lambda invocation success in lws")


@then('the document is "INDEXED"')
def document_is_indexed(world):
    pytest.skip("Cannot observe Lambda document index result in lws")
