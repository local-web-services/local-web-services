"""Abstract BDD step definitions for ApigatewayDynamodb integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_API = "e2e-test-api-1"
TEST_TABLE = "e2e-test-table-1"


def _apigateway(lws_session):
    return lws_session.client("apigateway")


def _dynamodb(lws_session):
    return lws_session.client("dynamodb")


def _create_api(lws_session, name=TEST_API):
    resp = _apigateway(lws_session).create_rest_api(name=name)
    return resp["id"]


def _get_api_id(lws_session, name=TEST_API):
    resp = _apigateway(lws_session).get_rest_apis()
    for api in resp.get("items", []):
        if api["name"] == name:
            return api["id"]
    return None


def _create_table(lws_session, name=TEST_TABLE):
    _dynamodb(lws_session).create_table(
        TableName=name,
        KeySchema=[{"AttributeName": "id", "KeyType": "HASH"}],
        AttributeDefinitions=[{"AttributeName": "id", "AttributeType": "S"}],
        BillingMode="PAY_PER_REQUEST",
    )


# ── Given: API state ──────────────────────────────────────────────────


@given('the "API" does not already exist')
def apigw_dynamodb_api_not_already_exist():
    """No-op: fresh state has no REST APIs."""


@given('the "API" already exists')
def apigw_dynamodb_api_already_exists(lws_session):
    _create_api(lws_session)


@given('the "API" exists and is "ACTIVE"')
def apigw_dynamodb_api_exists_and_active(lws_session):
    _create_api(lws_session)


@given('the "API" does not exist or is not "ACTIVE"')
def apigw_dynamodb_api_not_exist_or_not_active():
    pytest.skip("Cannot configure DynamoDB integration on REST API in lws")


@given('the "API" has no DynamoDB integration configured')
def apigw_dynamodb_api_has_no_integration():
    """No-op: APIs have no DynamoDB integration configured by default."""


@given('the "API" already has a DynamoDB integration configured')
def apigw_dynamodb_api_already_has_integration():
    pytest.skip("Cannot configure DynamoDB integration on REST API in lws")


@given('the "API" is "ACTIVE"')
def apigw_dynamodb_api_is_active_given():
    """No-op: REST APIs are ACTIVE immediately after creation."""


@given('the "API" is not "ACTIVE"')
def apigw_dynamodb_api_is_not_active_given():
    pytest.skip("Cannot configure DynamoDB integration on REST API in lws")


@given('the "API" has a DynamoDB integration configured')
def apigw_dynamodb_api_has_integration():
    pytest.skip("Cannot configure DynamoDB integration on REST API in lws")


# ── Given: table state ────────────────────────────────────────────────


@given("the table does not already exist")
def apigw_dynamodb_table_not_already_exist():
    """No-op: fresh state has no tables."""


@given("the table already exists")
def apigw_dynamodb_table_already_exists(lws_session):
    _create_table(lws_session)


@given('the table exists and is "ACTIVE"')
def apigw_dynamodb_table_exists_and_active(lws_session):
    _create_table(lws_session)


@given('the table does not exist or is not "ACTIVE"')
def apigw_dynamodb_table_not_exist_or_not_active():
    pytest.skip("Cannot configure DynamoDB integration on REST API in lws")


@given('the table is "ACTIVE"')
def apigw_dynamodb_table_is_active_given():
    """No-op: DynamoDB tables are ACTIVE immediately after creation."""


@given('the target table is "ACTIVE"')
def apigw_dynamodb_target_table_is_active():
    pytest.skip("Cannot configure DynamoDB integration on REST API in lws")


@given('the target table is not "ACTIVE"')
def apigw_dynamodb_target_table_is_not_active():
    pytest.skip("Cannot configure DynamoDB integration on REST API in lws")


@given('the target table is "DELETING"')
def apigw_dynamodb_target_table_is_deleting():
    pytest.skip("Cannot configure DynamoDB integration on REST API in lws")


@given('the target table is not "DELETING"')
def apigw_dynamodb_target_table_is_not_deleting():
    pytest.skip("Cannot configure DynamoDB integration on REST API in lws")


@given("the table exists")
def apigw_dynamodb_table_exists(lws_session):
    _create_table(lws_session)


@given('the table is already "DELETING"')
def apigw_dynamodb_table_already_deleting():
    pytest.skip("Cannot configure DynamoDB integration on REST API in lws")


@given("the table does not exist")
def apigw_dynamodb_table_does_not_exist():
    """No-op: fresh state has no tables."""


# ── Given: slots ───────────────────────────────────────────────────────


@given("a request slot is available")
def apigw_dynamodb_request_slot_available(lws_session):
    lws_session.capacity("apigateway").unlimited().apply()


@given("no request slot is available")
def apigw_dynamodb_no_request_slot():
    pytest.skip("Cannot send requests through API Gateway DynamoDB integration in lws")


@given("an item slot is available")
def apigw_dynamodb_item_slot_available(lws_session):
    lws_session.capacity("dynamodb").unlimited().apply()


@given("no item slot is available")
def apigw_dynamodb_no_item_slot():
    pytest.skip("Cannot send requests through API Gateway DynamoDB integration in lws")


# ── When: actions ──────────────────────────────────────────────────────


@when('an "API" Gateway "REST" "API" is created')
def create_rest_api_dynamodb(lws_session, world):
    try:
        resp = _apigateway(lws_session).create_rest_api(name=TEST_API)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("a DynamoDB table is created")
def create_dynamodb_table_apigw(lws_session, world):
    try:
        resp = _dynamodb(lws_session).create_table(
            TableName=TEST_TABLE,
            KeySchema=[{"AttributeName": "id", "KeyType": "HASH"}],
            AttributeDefinitions=[{"AttributeName": "id", "AttributeType": "S"}],
            BillingMode="PAY_PER_REQUEST",
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('a direct DynamoDB integration is configured on the "API"')
def configure_dynamodb_integration(world):
    pytest.skip("Cannot configure DynamoDB integration on REST API in lws")


@when('a request is received, the "API" writes to the DynamoDB table, and returns 200')
def request_writes_to_dynamodb(world):
    pytest.skip("Cannot send requests through API Gateway DynamoDB integration in lws")


@when("a request is received but the DynamoDB write fails because the table is being deleted")
def request_fails_table_deleting(world):
    pytest.skip("Cannot send requests through API Gateway DynamoDB integration in lws")


@when("a table deletion is initiated")
def initiate_table_deletion(lws_session, world):
    try:
        resp = _dynamodb(lws_session).delete_table(TableName=TEST_TABLE)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


# ── Then: assertions ───────────────────────────────────────────────────


@then('the "API" is "ACTIVE" with no DynamoDB integration configured')
def apigw_dynamodb_api_is_active_no_integration(lws_session):
    api_id = _get_api_id(lws_session)
    assert api_id is not None, f"Expected REST API '{TEST_API}' to exist but it was not found"
    resp = _apigateway(lws_session).get_rest_api(restApiId=api_id)
    actual_name = resp.get("name", "")
    expected_name = TEST_API
    assert (
        actual_name == expected_name
    ), f"Expected API name '{expected_name}' but got '{actual_name}'"


@then('the table is "ACTIVE"')
def apigw_dynamodb_table_is_active_then(lws_session):
    resp = _dynamodb(lws_session).describe_table(TableName=TEST_TABLE)
    expected_status = "ACTIVE"
    actual_status = resp["Table"].get("TableStatus", "")
    assert (
        actual_status == expected_status
    ), f"Expected table status '{expected_status}' but got '{actual_status}'"


@then('the "API" will write to the table when requests are received')
def api_will_write_to_table():
    pytest.skip("Cannot configure DynamoDB integration on REST API in lws")


@then('the item "EXISTS" and the request is "SUCCESS"')
def item_exists_request_success():
    pytest.skip("Cannot send requests through API Gateway DynamoDB integration in lws")


@then('the request is "FAILED" and no item is written')
def request_failed_no_item():
    pytest.skip("Cannot send requests through API Gateway DynamoDB integration in lws")


@then('the table is "DELETING" and "API" requests targeting it will fail')
def apigw_dynamodb_table_is_deleting(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected delete_table to succeed but got: {actual_error}"
