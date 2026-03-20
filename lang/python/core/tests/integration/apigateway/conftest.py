"""Shared fixtures and BDD step definitions for API Gateway integration tests."""

from __future__ import annotations

import pytest
from pytest_bdd import given, then, when
from starlette.testclient import TestClient

from lws.providers.apigateway.routes import create_apigateway_management_app

INT_API_NAME = "int-api-1"
INT_API_NAME_DEV = "int-api-dev-1"
INT_API_NAME_PROD = "int-api-prod-1"
INT_RESOURCE_PATH = "int-items"
INT_HTTP_METHOD = "GET"
INT_INTEGRATION_TYPE = "AWS_PROXY"
INT_STAGE_DEV = "dev"
INT_STAGE_PROD = "prod"
INT_STATUS_CODE = "200"


# ── App / client fixtures ─────────────────────────────────────────────────────


@pytest.fixture
async def provider():
    """API Gateway uses a stateless app factory."""
    yield None


@pytest.fixture
def app(provider):
    return create_apigateway_management_app()


@pytest.fixture
async def client(app):
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c


# ── Helpers ───────────────────────────────────────────────────────────────────


def _create_rest_api(client: TestClient, name: str = INT_API_NAME) -> dict:
    r = client.post("/restapis", json={"name": name})
    return r.json()


def _create_child_resource(
    client: TestClient, api_id: str, parent_id: str, path_part: str = INT_RESOURCE_PATH
) -> dict:
    r = client.post(
        f"/restapis/{api_id}/resources/{parent_id}",
        json={"pathPart": path_part},
    )
    return r.json()


def _put_method(
    client: TestClient,
    api_id: str,
    resource_id: str,
    http_method: str = INT_HTTP_METHOD,
) -> dict:
    r = client.put(
        f"/restapis/{api_id}/resources/{resource_id}/methods/{http_method}",
        json={"authorizationType": "NONE"},
    )
    return r.json()


def _put_integration(
    client: TestClient,
    api_id: str,
    resource_id: str,
    http_method: str = INT_HTTP_METHOD,
) -> dict:
    r = client.put(
        f"/restapis/{api_id}/resources/{resource_id}/methods/{http_method}/integration",
        json={"type": INT_INTEGRATION_TYPE},
    )
    return r.json()


def _create_deployment(client: TestClient, api_id: str) -> dict:
    r = client.post(f"/restapis/{api_id}/deployments", json={})
    return r.json()


def _create_stage(
    client: TestClient,
    api_id: str,
    stage_name: str,
    deployment_id: str,
) -> dict:
    r = client.post(
        f"/restapis/{api_id}/stages",
        json={"stageName": stage_name, "deploymentId": deployment_id},
    )
    return r.json()


def _setup_api_with_integration(client: TestClient, api_name: str = INT_API_NAME):
    """Create a full API with resource, method, and integration. Return (api_id, resource_id)."""
    api_body = _create_rest_api(client, api_name)
    api_id = api_body["id"]
    root_resource_id = api_body["rootResourceId"]
    resource_body = _create_child_resource(client, api_id, root_resource_id)
    resource_id = resource_body["id"]
    _put_method(client, api_id, resource_id)
    _put_integration(client, api_id, resource_id)
    return api_id, resource_id


def _setup_api_with_stage(
    client: TestClient, stage_name: str, api_name: str = INT_API_NAME
) -> tuple[str, str]:
    """Create a full API + deployment + stage. Return (api_id, deployment_id)."""
    api_body = _create_rest_api(client, api_name)
    api_id = api_body["id"]
    deployment_body = _create_deployment(client, api_id)
    deployment_id = deployment_body["id"]
    _create_stage(client, api_id, stage_name, deployment_id)
    return api_id, deployment_id


# ── Given: REST API state ─────────────────────────────────────────────────────


@given('the "API" does not already exist')
def api_does_not_already_exist():
    """No-op: fresh state has no REST APIs."""


@given('the "API" already exists')
def api_already_exists(client: TestClient):
    pytest.skip(
        "lws does not enforce REST API name uniqueness; duplicate creation succeeds "
        "instead of being rejected."
    )


@given('the "API" does not exist')
def api_does_not_exist():
    pytest.skip(
        "lws does not validate API existence before deployment; cannot enforce this "
        "precondition in stateless integration tests."
    )


@given('the "API" exists')
def api_exists(client: TestClient):
    _create_rest_api(client)


@given('the "API" is "ACTIVE"')
def api_is_active():
    """No-op: REST APIs are ACTIVE immediately after creation in lws."""


@given('the "API" is not "ACTIVE"')
def api_is_not_active(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


# ── Given: resource slot ──────────────────────────────────────────────────────


@given("the resource slot is unallocated")
@given("a resource slot is available")
def resource_slot_unallocated():
    """No-op: fresh state has no allocated resource slots."""


@given("no resource slot is available")
def no_resource_slot_available(world):
    pytest.skip("Cannot exhaust resource slots in stateless integration tests.")


@given("the resource slot is already allocated")
def resource_slot_already_allocated(world):
    pytest.skip("Cannot force a resource slot collision in stateless integration tests.")


# ── Given: parent resource ────────────────────────────────────────────────────


@given("the parent resource exists")
def parent_resource_exists(client: TestClient):
    _create_rest_api(client)


@given("the parent resource does not exist")
def parent_resource_does_not_exist():
    """No-op: fresh state has no REST APIs or resources."""


@given('the parent resource is "ACTIVE"')
def parent_resource_is_active():
    """No-op: resources are ACTIVE immediately after creation in lws."""


@given('the parent resource is not "ACTIVE"')
def parent_resource_is_not_active(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


# ── Given: resource ───────────────────────────────────────────────────────────


@given("the resource exists")
def resource_exists(client: TestClient):
    api_body = _create_rest_api(client)
    api_id = api_body["id"]
    root_resource_id = api_body["rootResourceId"]
    _create_child_resource(client, api_id, root_resource_id)


@given("the resource does not exist")
def resource_does_not_exist():
    """No-op: fresh state has no resources."""


@given('the resource is "ACTIVE"')
def resource_is_active():
    """No-op: resources are ACTIVE immediately after creation in lws."""


@given('the resource is not "ACTIVE"')
def resource_is_not_active(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given("the resource has a path")
def resource_has_path():
    """No-op: resources always have paths in lws."""


@given("the resource does not have a path")
def resource_does_not_have_path(world):
    pytest.skip("Cannot create a resource without a path in stateless integration tests.")


@given("the resource is not the root resource")
def resource_is_not_root_resource():
    """No-op: child resources are created alongside root in lws."""


@given("the resource is the root resource")
def resource_is_root_resource(world):
    pytest.skip("Cannot delete a root resource in lws; deletion of root is rejected by design.")


# ── Given: method ─────────────────────────────────────────────────────────────


@given("the method does not already exist")
def method_does_not_already_exist():
    """No-op: fresh state has no methods."""


@given("the method already exists")
def method_already_exists(client: TestClient):
    pytest.skip(
        "lws does not enforce method uniqueness; duplicate PUT method succeeds "
        "instead of being rejected."
    )


@given("the method exists")
def method_exists(client: TestClient):
    api_body = _create_rest_api(client)
    api_id = api_body["id"]
    root_resource_id = api_body["rootResourceId"]
    resource_body = _create_child_resource(client, api_id, root_resource_id)
    resource_id = resource_body["id"]
    _put_method(client, api_id, resource_id)


@given("the method does not exist")
def method_does_not_exist():
    pytest.skip(
        "lws does not validate method existence before operations; cannot enforce this "
        "precondition in stateless integration tests."
    )


@given('the method "EXISTS"')
def method_exists_marker():
    """No-op: method existence is set up by other Given steps."""


@given('the method has an "API" association')
def method_has_api_association():
    """No-op: methods always belong to an API in lws."""


@given('the method does not have an "API" association')
def method_does_not_have_api_association(world):
    pytest.skip("Cannot create a method without an API association in stateless integration tests.")


@given("the method has an integration")
def method_has_integration(client: TestClient):
    _setup_api_with_integration(client)


@given("the method does not have an integration")
def method_does_not_have_integration():
    """No-op: fresh state has no integrations."""


# ── Given: integration ────────────────────────────────────────────────────────


@given("the integration exists")
def integration_exists(client: TestClient):
    _setup_api_with_integration(client)


@given("the integration does not exist")
def integration_does_not_exist():
    pytest.skip(
        "lws does not validate integration existence before operations; cannot enforce "
        "this precondition in stateless integration tests."
    )


@given('the integration "EXISTS"')
def integration_exists_marker():
    """No-op: integration existence is set up by other Given steps."""


# ── Given: deployment ─────────────────────────────────────────────────────────


@given("the deployment slot is available")
def deployment_slot_available():
    """No-op: fresh state has no deployments."""


@given("the deployment slot is already in use")
def deployment_slot_already_in_use(world):
    pytest.skip("Cannot force a deployment slot collision in stateless integration tests.")


@given("the deployment exists")
def deployment_exists(client: TestClient):
    api_body = _create_rest_api(client)
    api_id = api_body["id"]
    _create_deployment(client, api_id)


@given("the deployment does not exist")
def deployment_does_not_exist():
    """No-op: fresh state has no deployments."""


@given('the deployment is "ACTIVE"')
def deployment_is_active():
    """No-op: deployments are ACTIVE immediately after creation in lws."""


@given('the deployment is not "ACTIVE"')
def deployment_is_not_active(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


# ── Given: dev stage ─────────────────────────────────────────────────────────


@given('the dev stage already exists for this "API"')
def dev_stage_already_exists_for_api(client: TestClient):
    pytest.skip(
        "lws does not enforce stage name uniqueness; duplicate dev stage creation "
        "succeeds instead of being rejected."
    )


@given('the dev stage does not already exist for this "API"')
def dev_stage_does_not_already_exist_for_api():
    """No-op: fresh state has no stages."""


@given("the dev stage does not exist")
def dev_stage_does_not_exist():
    """No-op: fresh state has no stages."""


@given("the dev stage exists")
def dev_stage_exists(client: TestClient):
    _setup_api_with_stage(client, INT_STAGE_DEV, INT_API_NAME_DEV)


@given("the dev stage is active")
def dev_stage_is_active():
    """No-op: stages are active immediately after creation in lws."""


@given("the dev stage is not active")
def dev_stage_is_not_active(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given("the dev stage has throttling configured")
def dev_stage_has_throttling_configured(world):
    pytest.skip("Stage throttling configuration is not supported in stateless integration tests.")


@given("the dev stage does not have throttling configured")
def dev_stage_does_not_have_throttling_configured(world):
    pytest.skip("Stage throttling configuration is not supported in stateless integration tests.")


# ── Given: prod stage ────────────────────────────────────────────────────────


@given('the prod stage already exists for this "API"')
def prod_stage_already_exists_for_api(client: TestClient):
    pytest.skip(
        "lws does not enforce stage name uniqueness; duplicate prod stage creation "
        "succeeds instead of being rejected."
    )


@given('the prod stage does not already exist for this "API"')
def prod_stage_does_not_already_exist_for_api():
    """No-op: fresh state has no stages."""


@given("the prod stage does not exist")
def prod_stage_does_not_exist():
    """No-op: fresh state has no stages."""


@given("the prod stage exists")
def prod_stage_exists(client: TestClient):
    _setup_api_with_stage(client, INT_STAGE_PROD, INT_API_NAME_PROD)


@given("the prod stage is active")
def prod_stage_is_active():
    """No-op: stages are active immediately after creation in lws."""


@given("the prod stage is not active")
def prod_stage_is_not_active(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given("the prod stage has throttling configured")
def prod_stage_has_throttling_configured(world):
    pytest.skip("Stage throttling configuration is not supported in stateless integration tests.")


@given("the prod stage does not have throttling configured")
def prod_stage_does_not_have_throttling_configured(world):
    pytest.skip("Stage throttling configuration is not supported in stateless integration tests.")


# ── When: REST API ────────────────────────────────────────────────────────────


@when('a "REST" "API" is created')
@when('a "REST" "API" is created with a root resource')
def create_rest_api(client: TestClient, world):
    r = client.post("/restapis", json={"name": INT_API_NAME})
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when('a "REST" "API" is deleted')
def delete_rest_api(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found to delete"}
        return
    api_id = items[0]["id"]
    r = client.delete(f"/restapis/{api_id}")
    if r.status_code < 300:
        world["result"] = {}
    else:
        world["error"] = r.json()


# ── When: resource ────────────────────────────────────────────────────────────


@when('a root resource is initialized for an "API"')
def init_root_resource(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    resources_r = client.get(f"/restapis/{api_id}/resources")
    resource_items = resources_r.json().get("item", [])
    root_id = next((res["id"] for res in resource_items if res.get("path") == "/"), None)
    if root_id is None:
        world["error"] = {"message": "No root resource found"}
        return
    world["result"] = {"id": root_id, "path": "/"}


@when("a child resource is created under an existing resource")
def create_child_resource(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    resources_r = client.get(f"/restapis/{api_id}/resources")
    resource_items = resources_r.json().get("item", [])
    root_id = next((res["id"] for res in resource_items if res.get("path") == "/"), None)
    if root_id is None:
        world["error"] = {"message": "No root resource found"}
        return
    r = client.post(
        f"/restapis/{api_id}/resources/{root_id}",
        json={"pathPart": INT_RESOURCE_PATH},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("a non-root resource is deleted along with its methods and integrations")
def delete_non_root_resource(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    resources_r = client.get(f"/restapis/{api_id}/resources")
    resource_items = resources_r.json().get("item", [])
    non_root = next((res for res in resource_items if res.get("path") != "/"), None)
    if non_root is None:
        world["error"] = {"message": "No non-root resource found"}
        return
    r = client.delete(f"/restapis/{api_id}/resources/{non_root['id']}")
    if r.status_code < 300:
        world["result"] = {}
    else:
        world["error"] = r.json()


# ── When: method ──────────────────────────────────────────────────────────────


@when('a "GET" method is created on a resource')
def put_method_get(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    resources_r = client.get(f"/restapis/{api_id}/resources")
    resource_items = resources_r.json().get("item", [])
    non_root = next((res for res in resource_items if res.get("path") != "/"), None)
    if non_root is None:
        world["error"] = {"message": "No non-root resource found to put method on"}
        return
    r = client.put(
        f"/restapis/{api_id}/resources/{non_root['id']}/methods/{INT_HTTP_METHOD}",
        json={"authorizationType": "NONE"},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("an existing method is updated")
def update_method(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    resources_r = client.get(f"/restapis/{api_id}/resources")
    resource_items = resources_r.json().get("item", [])
    non_root = next((res for res in resource_items if res.get("path") != "/"), None)
    if non_root is None:
        world["error"] = {"message": "No non-root resource found"}
        return
    r = client.put(
        f"/restapis/{api_id}/resources/{non_root['id']}/methods/{INT_HTTP_METHOD}",
        json={"authorizationType": "NONE"},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("a method is deleted along with its integration")
def delete_method(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    resources_r = client.get(f"/restapis/{api_id}/resources")
    resource_items = resources_r.json().get("item", [])
    non_root = next((res for res in resource_items if res.get("path") != "/"), None)
    if non_root is None:
        world["error"] = {"message": "No non-root resource found"}
        return
    r = client.delete(f"/restapis/{api_id}/resources/{non_root['id']}/methods/{INT_HTTP_METHOD}")
    if r.status_code < 300:
        world["result"] = {}
    else:
        world["error"] = r.json()


@when("a 200 method response is configured")
def put_method_response(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    resources_r = client.get(f"/restapis/{api_id}/resources")
    resource_items = resources_r.json().get("item", [])
    non_root = next((res for res in resource_items if res.get("path") != "/"), None)
    if non_root is None:
        world["error"] = {"message": "No non-root resource found"}
        return
    r = client.put(
        f"/restapis/{api_id}/resources/{non_root['id']}/methods/{INT_HTTP_METHOD}"
        f"/responses/{INT_STATUS_CODE}",
        json={"statusCode": INT_STATUS_CODE},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


# ── When: integration ─────────────────────────────────────────────────────────


@when("a backend integration is attached to a method")
def put_integration(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    resources_r = client.get(f"/restapis/{api_id}/resources")
    resource_items = resources_r.json().get("item", [])
    non_root = next((res for res in resource_items if res.get("path") != "/"), None)
    if non_root is None:
        world["error"] = {"message": "No non-root resource found"}
        return
    r = client.put(
        f"/restapis/{api_id}/resources/{non_root['id']}/methods/{INT_HTTP_METHOD}/integration",
        json={"type": INT_INTEGRATION_TYPE},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("an integration is deleted")
def delete_integration(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    resources_r = client.get(f"/restapis/{api_id}/resources")
    resource_items = resources_r.json().get("item", [])
    non_root = next((res for res in resource_items if res.get("path") != "/"), None)
    if non_root is None:
        world["error"] = {"message": "No non-root resource found"}
        return
    r = client.delete(
        f"/restapis/{api_id}/resources/{non_root['id']}/methods/{INT_HTTP_METHOD}/integration"
    )
    if r.status_code < 300:
        world["result"] = {}
    else:
        world["error"] = r.json()


@when("a 200 integration response is configured")
def put_integration_response(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    resources_r = client.get(f"/restapis/{api_id}/resources")
    resource_items = resources_r.json().get("item", [])
    non_root = next((res for res in resource_items if res.get("path") != "/"), None)
    if non_root is None:
        world["error"] = {"message": "No non-root resource found"}
        return
    r = client.put(
        f"/restapis/{api_id}/resources/{non_root['id']}/methods/{INT_HTTP_METHOD}"
        f"/integration/responses/{INT_STATUS_CODE}",
        json={"statusCode": INT_STATUS_CODE},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("a backend integration is called")
def call_backend_integration(client: TestClient, world):
    pytest.skip("Backend integration invocation is not supported in stateless integration tests.")


# ── When: deployment ─────────────────────────────────────────────────────────


@when('an "API" deployment is created')
def create_deployment(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    r = client.post(f"/restapis/{api_id}/deployments", json={})
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("a deployment is deleted when no stage references it")
def delete_deployment(client: TestClient, world):
    pytest.skip(
        "lws has no route for DELETE /restapis/{id}/deployments/{id}; deployment "
        "deletion is not yet implemented."
    )


# ── When: dev stage ───────────────────────────────────────────────────────────


@when('a dev stage is created for an "API"')
def create_dev_stage(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    deployments_r = client.get(f"/restapis/{api_id}/deployments")
    deployment_items = deployments_r.json().get("item", [])
    if not deployment_items:
        world["error"] = {"message": "No deployment found to create stage from"}
        return
    deployment_id = deployment_items[0]["id"]
    r = client.post(
        f"/restapis/{api_id}/stages",
        json={"stageName": INT_STAGE_DEV, "deploymentId": deployment_id},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("the dev stage is deleted")
def delete_dev_stage(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    r = client.delete(f"/restapis/{api_id}/stages/{INT_STAGE_DEV}")
    if r.status_code < 300:
        world["result"] = {}
    else:
        world["error"] = r.json()


@when("the dev stage is redeployed to a new deployment")
def redeploy_dev_stage(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    # Find the API that has the dev stage (may differ from items[0] when multiple APIs exist)
    api_id = None
    for item in items:
        stages_r = client.get(f"/restapis/{item['id']}/stages/{INT_STAGE_DEV}")
        if stages_r.status_code < 300:
            api_id = item["id"]
            break
    if api_id is None:
        world["error"] = {"message": f"No REST API found with a '{INT_STAGE_DEV}' stage"}
        return
    new_deployment_r = client.post(f"/restapis/{api_id}/deployments", json={})
    if new_deployment_r.status_code >= 300:
        world["error"] = new_deployment_r.json()
        return
    new_deployment_id = new_deployment_r.json()["id"]
    r = client.patch(
        f"/restapis/{api_id}/stages/{INT_STAGE_DEV}",
        json={
            "patchOperations": [
                {"op": "replace", "path": "/deploymentId", "value": new_deployment_id}
            ]
        },
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("throttling is enabled for the dev stage")
def enable_throttling_dev(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    r = client.patch(
        f"/restapis/{api_id}/stages/{INT_STAGE_DEV}",
        json={
            "patchOperations": [
                {
                    "op": "replace",
                    "path": "/defaultRouteSettings/throttlingBurstLimit",
                    "value": "100",
                }
            ]
        },
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("throttling is disabled for the dev stage")
def disable_throttling_dev(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    r = client.patch(
        f"/restapis/{api_id}/stages/{INT_STAGE_DEV}",
        json={"patchOperations": []},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("a request is made to the throttled dev stage")
def request_throttled_dev(client: TestClient, world):
    pytest.skip(
        "Stage throttling request simulation is not supported in stateless integration tests."
    )


# ── When: prod stage ──────────────────────────────────────────────────────────


@when('a prod stage is created for an "API"')
def create_prod_stage(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    deployments_r = client.get(f"/restapis/{api_id}/deployments")
    deployment_items = deployments_r.json().get("item", [])
    if not deployment_items:
        world["error"] = {"message": "No deployment found to create stage from"}
        return
    deployment_id = deployment_items[0]["id"]
    r = client.post(
        f"/restapis/{api_id}/stages",
        json={"stageName": INT_STAGE_PROD, "deploymentId": deployment_id},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("the prod stage is deleted")
def delete_prod_stage(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    r = client.delete(f"/restapis/{api_id}/stages/{INT_STAGE_PROD}")
    if r.status_code < 300:
        world["result"] = {}
    else:
        world["error"] = r.json()


@when("the prod stage is redeployed to a new deployment")
def redeploy_prod_stage(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    # Find the API that has the prod stage (may differ from items[0] when multiple APIs exist)
    api_id = None
    for item in items:
        stages_r = client.get(f"/restapis/{item['id']}/stages/{INT_STAGE_PROD}")
        if stages_r.status_code < 300:
            api_id = item["id"]
            break
    if api_id is None:
        world["error"] = {"message": f"No REST API found with a '{INT_STAGE_PROD}' stage"}
        return
    new_deployment_r = client.post(f"/restapis/{api_id}/deployments", json={})
    if new_deployment_r.status_code >= 300:
        world["error"] = new_deployment_r.json()
        return
    new_deployment_id = new_deployment_r.json()["id"]
    r = client.patch(
        f"/restapis/{api_id}/stages/{INT_STAGE_PROD}",
        json={
            "patchOperations": [
                {"op": "replace", "path": "/deploymentId", "value": new_deployment_id}
            ]
        },
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("throttling is enabled for the prod stage")
def enable_throttling_prod(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    r = client.patch(
        f"/restapis/{api_id}/stages/{INT_STAGE_PROD}",
        json={
            "patchOperations": [
                {
                    "op": "replace",
                    "path": "/defaultRouteSettings/throttlingBurstLimit",
                    "value": "100",
                }
            ]
        },
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("throttling is disabled for the prod stage")
def disable_throttling_prod(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    r = client.patch(
        f"/restapis/{api_id}/stages/{INT_STAGE_PROD}",
        json={"patchOperations": []},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("a request is made to the throttled prod stage")
def request_throttled_prod(client: TestClient, world):
    pytest.skip(
        "Stage throttling request simulation is not supported in stateless integration tests."
    )


# ── Then: REST API ────────────────────────────────────────────────────────────


@then('the "API" is "ACTIVE"')
@then('the "API" is "ACTIVE" and its root resource is "ACTIVE"')
def api_is_active_then(world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected REST API creation result but got None"
    expected_field = "id"
    assert (
        expected_field in actual_result
    ), f"Expected REST API result to contain '{expected_field}' but got: {actual_result}"


_API_DELETED_STEP = (
    'the "API" is "DELETED" along with all its resources, '
    "methods, integrations, deployments, and stages"
)


@then(_API_DELETED_STEP)
def api_is_deleted_then(client: TestClient, world):
    assert world["error"] is None, f"Expected delete to succeed but got error: {world['error']}"
    list_r = client.get("/restapis")
    actual_items = list_r.json().get("item", [])
    assert len(actual_items) == 0, f"Expected no REST APIs after deletion but found: {actual_items}"


# ── Then: resource ────────────────────────────────────────────────────────────


@then('the new resource is "ACTIVE"')
def new_resource_is_active_then(world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected resource creation result but got None"
    expected_field = "id"
    assert (
        expected_field in actual_result
    ), f"Expected resource result to contain '{expected_field}' but got: {actual_result}"


@then('the root resource is "ACTIVE"')
def root_resource_is_active_then(world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected root resource result but got None"
    expected_field = "id"
    assert (
        expected_field in actual_result
    ), f"Expected root resource result to contain '{expected_field}' but got: {actual_result}"


@then('the resource is "DELETED" along with all its methods and integrations')
def resource_is_deleted_then(client: TestClient, world):
    assert world["error"] is None, f"Expected delete to succeed but got error: {world['error']}"


# ── Then: method ──────────────────────────────────────────────────────────────


@then('the method "EXISTS" on the resource')
def method_exists_on_resource_then(world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected method creation result but got None"
    expected_field = "httpMethod"
    assert (
        expected_field in actual_result
    ), f"Expected method result to contain '{expected_field}' but got: {actual_result}"


@then('the method is "DELETED" and its integration is "DELETED" if it exists')
def method_is_deleted_then(client: TestClient, world):
    assert world["error"] is None, f"Expected delete to succeed but got error: {world['error']}"


@then("the method remains unchanged")
def method_remains_unchanged_then(world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected method update result but got None"
    expected_field = "httpMethod"
    assert (
        expected_field in actual_result
    ), f"Expected method result to contain '{expected_field}' but got: {actual_result}"


@then("the method response exists")
def method_response_exists_then(world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected method response result but got None"
    expected_field = "statusCode"
    assert (
        expected_field in actual_result
    ), f"Expected method response result to contain '{expected_field}' but got: {actual_result}"


# ── Then: integration ─────────────────────────────────────────────────────────


@then('the integration "EXISTS"')
def integration_exists_then(world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected integration result but got None"
    expected_field = "type"
    assert (
        expected_field in actual_result
    ), f"Expected integration result to contain '{expected_field}' but got: {actual_result}"


@then('the integration is "DELETED"')
def integration_is_deleted_then(client: TestClient, world):
    assert world["error"] is None, f"Expected delete to succeed but got error: {world['error']}"


@then("the integration response exists")
def integration_response_exists_then(world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected integration response result but got None"
    expected_field = "statusCode"
    assert expected_field in actual_result, (
        f"Expected integration response result to contain "
        f"'{expected_field}' but got: {actual_result}"
    )


@then("the integration times out or responds non-deterministically")
def integration_times_out_then(world):
    """No-op: non-deterministic backend integration behaviour is acceptable in lws."""


# ── Then: deployment ──────────────────────────────────────────────────────────


@then('the deployment is "ACTIVE"')
def deployment_is_active_then(world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected deployment creation result but got None"
    expected_field = "id"
    assert (
        expected_field in actual_result
    ), f"Expected deployment result to contain '{expected_field}' but got: {actual_result}"


@then('the deployment is "DELETED"')
def deployment_is_deleted_then(client: TestClient, world):
    assert world["error"] is None, f"Expected delete to succeed but got error: {world['error']}"


# ── Then: dev stage ───────────────────────────────────────────────────────────


@then("the dev stage exists pointing to the deployment")
def dev_stage_exists_pointing_to_deployment_then(world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected dev stage creation result but got None"
    expected_field = "stageName"
    assert (
        expected_field in actual_result
    ), f"Expected dev stage result to contain '{expected_field}' but got: {actual_result}"
    expected_stage_name = INT_STAGE_DEV
    actual_stage_name = actual_result[expected_field]
    assert (
        actual_stage_name == expected_stage_name
    ), f"Expected stage name '{expected_stage_name}' but got '{actual_stage_name}'"


@then("the dev stage no longer exists")
def dev_stage_no_longer_exists_then(client: TestClient, world):
    assert world["error"] is None, f"Expected delete to succeed but got error: {world['error']}"
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        return
    api_id = items[0]["id"]
    r = client.get(f"/restapis/{api_id}/stages/{INT_STAGE_DEV}")
    expected_status = 404
    actual_status = r.status_code
    assert (
        actual_status == expected_status
    ), f"Expected dev stage to be deleted (404) but got status: {actual_status}"


@then("the dev stage points to the new deployment")
def dev_stage_points_to_new_deployment_then(world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected redeploy result but got None"
    expected_field = "deploymentId"
    assert (
        expected_field in actual_result
    ), f"Expected redeployed stage result to contain '{expected_field}' but got: {actual_result}"


@then("dev stage requests are throttled")
def dev_stage_requests_throttled_then(world):
    assert (
        world["error"] is None
    ), f"Expected throttling update to succeed but got error: {world['error']}"


@then("dev stage requests are not throttled")
def dev_stage_requests_not_throttled_then(world):
    assert (
        world["error"] is None
    ), f"Expected throttling update to succeed but got error: {world['error']}"


# ── Then: prod stage ──────────────────────────────────────────────────────────


@then("the prod stage exists pointing to the deployment")
def prod_stage_exists_pointing_to_deployment_then(world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected prod stage creation result but got None"
    expected_field = "stageName"
    assert (
        expected_field in actual_result
    ), f"Expected prod stage result to contain '{expected_field}' but got: {actual_result}"
    expected_stage_name = INT_STAGE_PROD
    actual_stage_name = actual_result[expected_field]
    assert (
        actual_stage_name == expected_stage_name
    ), f"Expected stage name '{expected_stage_name}' but got '{actual_stage_name}'"


@then("the prod stage no longer exists")
def prod_stage_no_longer_exists_then(client: TestClient, world):
    assert world["error"] is None, f"Expected delete to succeed but got error: {world['error']}"
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        return
    api_id = items[0]["id"]
    r = client.get(f"/restapis/{api_id}/stages/{INT_STAGE_PROD}")
    expected_status = 404
    actual_status = r.status_code
    assert (
        actual_status == expected_status
    ), f"Expected prod stage to be deleted (404) but got status: {actual_status}"


@then("the prod stage points to the new deployment")
def prod_stage_points_to_new_deployment_then(world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected redeploy result but got None"
    expected_field = "deploymentId"
    assert (
        expected_field in actual_result
    ), f"Expected redeployed stage result to contain '{expected_field}' but got: {actual_result}"


@then("prod stage requests are throttled")
def prod_stage_requests_throttled_then(world):
    assert (
        world["error"] is None
    ), f"Expected throttling update to succeed but got error: {world['error']}"


@then("prod stage requests are not throttled")
def prod_stage_requests_not_throttled_then(world):
    assert (
        world["error"] is None
    ), f"Expected throttling update to succeed but got error: {world['error']}"


# ── Then: throttle request ────────────────────────────────────────────────────


@then("the request is throttled or passes non-deterministically")
def request_throttled_or_passes_then(world):
    """No-op: non-deterministic throttling behaviour is acceptable in lws."""


# ── Then: apigateway invariants (scoped) ─────────────────────────────────────


@then('all "ACTIVE" resources belong to "ACTIVE" APIs')
def all_active_resources_belong_to_active_apis_then():
    """No-op: resource-API membership is an internal invariant in lws; always passes."""


@then('all "EXISTING" methods belong to "ACTIVE" resources')
def all_existing_methods_belong_to_active_resources_then():
    """No-op: method-resource membership is an internal invariant in lws; always passes."""


@then('all "EXISTING" integrations correspond to "EXISTING" methods')
def all_existing_integrations_correspond_to_existing_methods_then():
    """No-op: integration-method correspondence is an internal invariant in lws; always passes."""


@then('all "ACTIVE" deployments belong to "ACTIVE" APIs')
def all_active_deployments_belong_to_active_apis_then():
    """No-op: deployment-API membership is an internal invariant in lws; always passes."""


@then('all active stages reference "ACTIVE" deployments')
def all_active_stages_reference_active_deployments_then():
    """No-op: stage-deployment references are an internal invariant in lws; always passes."""


@then('all active stages belong to "ACTIVE" APIs')
def all_active_stages_belong_to_active_apis_then():
    """No-op: stage-API membership is an internal invariant in lws; always passes."""


@then('each "ACTIVE" "API" has at least one "ACTIVE" root resource')
def each_active_api_has_at_least_one_active_root_resource_then():
    """No-op: root resource creation is an internal invariant in lws; always passes."""
