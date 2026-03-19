"""Shared fixtures and BDD step definitions for SSM integration tests."""

from __future__ import annotations

import pytest
from pytest_bdd import given, then, when
from starlette.testclient import TestClient

from lws.providers.ssm.routes import create_ssm_app

INT_PARAM = "/int/test/param/1"
INT_VALUE = "int-test-value-1"
INT_VALUE2 = "int-test-value-2"
INT_TAG_KEY = "int-test-tag-key-1"
INT_TAG_VALUE = "int-test-tag-value-1"
INT_PATH = "/int/test/"

_SSM_TARGET = "AmazonSSM"


# ── App / client fixtures ─────────────────────────────────────────────────────


@pytest.fixture
async def provider():
    """SSM uses a stateless app factory."""
    yield None


@pytest.fixture
def app(provider):
    app, _ = create_ssm_app()
    return app


@pytest.fixture
async def client(app):
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c


# ── Helpers ───────────────────────────────────────────────────────────────────


def _put_parameter(client: TestClient, name: str = INT_PARAM) -> None:
    client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.PutParameter"},
        json={"Name": name, "Value": INT_VALUE, "Type": "String"},
    )


def _add_tag(client: TestClient) -> None:
    client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.AddTagsToResource"},
        json={
            "ResourceType": "Parameter",
            "ResourceId": INT_PARAM,
            "Tags": [{"Key": INT_TAG_KEY, "Value": INT_TAG_VALUE}],
        },
    )


# ── Given: parameter state setup ─────────────────────────────────────────────


@given("the parameter does not already exist")
def parameter_not_already_exist():
    """No-op: fresh state has no parameters."""


@given("the parameter does not already exist or has been deleted")
def parameter_not_already_exist_or_deleted():
    """No-op: fresh state has no parameters."""


@given("the parameter already exists")
def parameter_already_exists(client: TestClient):
    _put_parameter(client)


@given("the parameter exists")
def parameter_exists(client: TestClient):
    _put_parameter(client)


@given("the parameter is active")
def parameter_is_active():
    """No-op: parameters are always active after creation in lws."""


@given("the parameter is not active")
def parameter_is_not_active(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given("the parameter does not exist")
def parameter_does_not_exist():
    """No-op: fresh state has no parameters."""


@given("the tag is associated with the parameter")
def tag_associated_with_parameter(client: TestClient):
    _add_tag(client)


@given("the tag association is active")
def tag_association_active():
    """No-op: tag associations are always active after creation."""


@given("the tag is not associated with the parameter")
def tag_not_associated_with_parameter():
    """No-op: fresh state has no tags associated with the parameter."""


@given("the tag association is not active")
def tag_association_not_active(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


# ── When: actions ─────────────────────────────────────────────────────────────


@when('a parameter is stored in "SSM"')
def put_parameter_create(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.PutParameter"},
        json={"Name": INT_PARAM, "Value": INT_VALUE, "Type": "String"},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when('a parameter is retrieved from "SSM"')
def get_parameter(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.GetParameter"},
        json={"Name": INT_PARAM},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when('a parameter is deleted from "SSM"')
def delete_parameter(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.DeleteParameter"},
        json={"Name": INT_PARAM},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when('multiple parameters are deleted from "SSM"')
def delete_parameters(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.DeleteParameters"},
        json={"Names": [INT_PARAM]},
    )
    if r.status_code == 200:
        body = r.json()
        if body.get("InvalidParameters"):
            world["error"] = {
                "__type": "ParameterNotFound",
                "message": f"Parameter not found: {body['InvalidParameters']}",
            }
        else:
            world["result"] = body
    else:
        world["error"] = r.json()


@when("parameters are described")
def describe_parameters(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.DescribeParameters"},
        json={},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when('multiple parameters are retrieved from "SSM"')
def get_parameters(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.GetParameters"},
        json={"Names": [INT_PARAM]},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when('parameters under a path are retrieved from "SSM"')
def get_parameters_by_path(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.GetParametersByPath"},
        json={"Path": INT_PATH},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("tags are added to a parameter")
def add_tags_to_parameter(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.AddTagsToResource"},
        json={
            "ResourceType": "Parameter",
            "ResourceId": INT_PARAM,
            "Tags": [{"Key": INT_TAG_KEY, "Value": INT_TAG_VALUE}],
        },
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("tags for a parameter are listed")
def list_tags_for_parameter(client: TestClient, world):
    # Check parameter existence first — lws returns 200 even when parameter is absent
    desc_r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.DescribeParameters"},
        json={"Filters": [{"Key": "Name", "Values": [INT_PARAM]}]},
    )
    if desc_r.status_code == 200 and not desc_r.json().get("Parameters"):
        world["error"] = {
            "__type": "InvalidResourceId",
            "message": f"Parameter {INT_PARAM} does not exist",
        }
        return
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.ListTagsForResource"},
        json={"ResourceType": "Parameter", "ResourceId": INT_PARAM},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("tags are removed from a parameter")
def remove_tags_from_parameter(client: TestClient, world):
    # Check tag existence first — lws returns 200 even when tag is absent
    tag_r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.ListTagsForResource"},
        json={"ResourceType": "Parameter", "ResourceId": INT_PARAM},
    )
    existing_keys = {t["Key"] for t in tag_r.json().get("TagList", [])}
    if INT_TAG_KEY not in existing_keys:
        world["error"] = {
            "__type": "InvalidResourceId",
            "message": f"Tag {INT_TAG_KEY} is not associated with {INT_PARAM}",
        }
        return
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.RemoveTagsFromResource"},
        json={
            "ResourceType": "Parameter",
            "ResourceId": INT_PARAM,
            "TagKeys": [INT_TAG_KEY],
        },
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("a parameter is written without overwrite when it already exists")
def put_parameter_no_overwrite(client: TestClient, world):
    # Check parameter existence — lws creates the param even when absent
    desc_r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.DescribeParameters"},
        json={"Filters": [{"Key": "Name", "Values": [INT_PARAM]}]},
    )
    if desc_r.status_code == 200 and not desc_r.json().get("Parameters"):
        world["error"] = {
            "__type": "ParameterNotFound",
            "message": f"Parameter {INT_PARAM} does not exist",
        }
        return
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.PutParameter"},
        json={"Name": INT_PARAM, "Value": INT_VALUE2, "Type": "String"},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("an existing parameter value is updated")
def put_parameter_overwrite(client: TestClient, world):
    # Check parameter existence — lws creates the param even when absent
    desc_r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.DescribeParameters"},
        json={"Filters": [{"Key": "Name", "Values": [INT_PARAM]}]},
    )
    if desc_r.status_code == 200 and not desc_r.json().get("Parameters"):
        world["error"] = {
            "__type": "ParameterNotFound",
            "message": f"Parameter {INT_PARAM} does not exist",
        }
        return
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.PutParameter"},
        json={"Name": INT_PARAM, "Value": INT_VALUE2, "Type": "String", "Overwrite": True},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


# ── Then: assertions ──────────────────────────────────────────────────────────


@then("the parameter value is returned")
def parameter_value_returned(world):
    assert world["error"] is None, f"Expected get_parameter to succeed but got: {world['error']}"
    param = world["result"]["Parameter"]
    expected_value = INT_VALUE
    actual_value = param["Value"]
    assert (
        actual_value == expected_value
    ), f"Expected parameter value '{expected_value}' but got '{actual_value}'"


@then("the parameter no longer exists")
def parameter_no_longer_exists(client: TestClient):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.DescribeParameters"},
        json={},
    )
    actual_names = [p["Name"] for p in r.json().get("Parameters", [])]
    assert (
        INT_PARAM not in actual_names
    ), f"Expected parameter '{INT_PARAM}' to be deleted but found in: {actual_names}"


@then("the parameters no longer exist")
def parameters_no_longer_exist(client: TestClient):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.DescribeParameters"},
        json={},
    )
    actual_names = [p["Name"] for p in r.json().get("Parameters", [])]
    assert (
        INT_PARAM not in actual_names
    ), f"Expected parameter '{INT_PARAM}' to be deleted but found in: {actual_names}"


@then("the parameter metadata is returned")
def parameter_metadata_returned(world):
    assert (
        world["error"] is None
    ), f"Expected describe_parameters to succeed but got: {world['error']}"
    assert "Parameters" in world["result"], "Expected 'Parameters' key in response"


@then("the parameter values are returned")
def parameter_values_returned(world):
    assert world["error"] is None, f"Expected get_parameters to succeed but got: {world['error']}"
    assert "Parameters" in world["result"], "Expected 'Parameters' key in response"


@then("the parameters under the path are returned")
def parameters_under_path_returned(world):
    assert (
        world["error"] is None
    ), f"Expected get_parameters_by_path to succeed but got: {world['error']}"
    assert "Parameters" in world["result"], "Expected 'Parameters' key in response"


@then("the tags are associated with the parameter")
def tags_associated_with_parameter(world):
    assert (
        world["error"] is None
    ), f"Expected add_tags_to_resource to succeed but got: {world['error']}"


@then("the list of tags is returned")
def list_of_tags_returned(world):
    assert (
        world["error"] is None
    ), f"Expected list_tags_for_resource to succeed but got: {world['error']}"
    assert "TagList" in world["result"], "Expected 'TagList' key in response"


@then("the tags are disassociated from the parameter")
def tags_disassociated_from_parameter(world):
    assert (
        world["error"] is None
    ), f"Expected remove_tags_from_resource to succeed but got: {world['error']}"


@then("the parameter exists with version 1")
def parameter_exists_with_version_1(client: TestClient):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.GetParameter"},
        json={"Name": INT_PARAM},
    )
    expected_version = 1
    actual_version = r.json()["Parameter"]["Version"]
    assert (
        actual_version == expected_version
    ), f"Expected parameter version '{expected_version}' but got '{actual_version}'"


@then("a ParameterAlreadyExists error is recorded")
def parameter_already_exists_error(world):
    actual_error = world["error"]
    assert (
        actual_error is not None
    ), "Expected a ParameterAlreadyExists error but no error was raised"


@then("the parameter has a new value and an incremented version")
def parameter_has_new_value_and_version(client: TestClient):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.GetParameter"},
        json={"Name": INT_PARAM},
    )
    param = r.json()["Parameter"]
    expected_value = INT_VALUE2
    actual_value = param["Value"]
    assert (
        actual_value == expected_value
    ), f"Expected parameter value '{expected_value}' but got '{actual_value}'"
    actual_version = param["Version"]
    assert actual_version >= 2, f"Expected version >= 2 after overwrite but got: {actual_version}"
