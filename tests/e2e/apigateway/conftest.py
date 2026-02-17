"""Shared fixtures for apigateway E2E tests."""

from __future__ import annotations

import json
import subprocess
import tempfile
from pathlib import Path

import pytest
from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()

# ── Docker / image availability checks ────────────────────────────────

_DOCKER_AVAILABLE = True
try:
    subprocess.run(["docker", "info"], capture_output=True, timeout=5, check=True)
except (subprocess.CalledProcessError, FileNotFoundError, subprocess.TimeoutExpired):
    _DOCKER_AVAILABLE = False

_PYTHON_IMAGE_AVAILABLE = False
if _DOCKER_AVAILABLE:
    try:
        result = subprocess.run(
            ["docker", "images", "-q", "public.ecr.aws/lambda/python:3.12"],
            capture_output=True,
            timeout=5,
            text=True,
        )
        _PYTHON_IMAGE_AVAILABLE = bool(result.stdout.strip())
    except (subprocess.CalledProcessError, FileNotFoundError, subprocess.TimeoutExpired):
        pass


def pytest_collection_modifyitems(config, items):
    for item in items:
        if "requires_docker" in item.keywords:
            if not _DOCKER_AVAILABLE:
                item.add_marker(pytest.mark.skip(reason="Docker daemon not reachable"))
            elif not _PYTHON_IMAGE_AVAILABLE:
                item.add_marker(
                    pytest.mark.skip(reason="public.ecr.aws/lambda/python:3.12 image not available")
                )


# ── Echo Lambda handler ──────────────────────────────────────────────

_ECHO_HANDLER_CODE = """\
import json

def handler(event, context):
    return {
        "statusCode": 200,
        "body": json.dumps(event, default=str),
        "headers": {"content-type": "application/json"},
    }
"""


@pytest.fixture()
def echo_handler_dir():
    """Create a temporary directory with a Python echo handler."""
    with tempfile.TemporaryDirectory(dir=str(Path.home())) as d:
        handler_file = Path(d) / "handler.py"
        handler_file.write_text(_ECHO_HANDLER_CODE)
        yield d


# ── Step definitions ──────────────────────────────────────────────────


@given(
    "a deployment was created for the REST API",
    target_fixture="deployment",
)
def a_deployment_was_created(rest_api, lws_invoke, e2e_port):
    result = lws_invoke(
        [
            "apigateway",
            "create-deployment",
            "--rest-api-id",
            rest_api["id"],
            "--port",
            str(e2e_port),
        ]
    )
    return {"id": result["id"]}


@given(
    parsers.parse('a resource "{path_part}" was created under the root'),
    target_fixture="resource",
)
def a_resource_was_created(path_part, rest_api, lws_invoke, e2e_port):
    result = lws_invoke(
        [
            "apigateway",
            "create-resource",
            "--rest-api-id",
            rest_api["id"],
            "--parent-id",
            rest_api["rootResourceId"],
            "--path-part",
            path_part,
            "--port",
            str(e2e_port),
        ]
    )
    return {"id": result["id"], "path_part": path_part}


@given(
    parsers.parse('a REST API "{name}" was created'),
    target_fixture="rest_api",
)
def a_rest_api_was_created(name, lws_invoke, e2e_port):
    result = lws_invoke(
        [
            "apigateway",
            "create-rest-api",
            "--name",
            name,
            "--port",
            str(e2e_port),
        ]
    )
    return {
        "id": result["id"],
        "rootResourceId": result["rootResourceId"],
        "name": name,
    }


@given(
    parsers.parse('a stage named "{stage_name}" was created for the REST API'),
)
def a_stage_was_created(stage_name, rest_api, deployment, lws_invoke, e2e_port):
    lws_invoke(
        [
            "apigateway",
            "create-stage",
            "--rest-api-id",
            rest_api["id"],
            "--stage-name",
            stage_name,
            "--deployment-id",
            deployment["id"],
            "--port",
            str(e2e_port),
        ]
    )


@given(
    parsers.parse('a V2 API "{name}" was created'),
    target_fixture="v2_api",
)
def a_v2_api_was_created(name, lws_invoke, e2e_port):
    result = lws_invoke(
        [
            "apigateway",
            "v2-create-api",
            "--name",
            name,
            "--port",
            str(e2e_port),
        ]
    )
    return {"apiId": result["apiId"], "name": name}


@given(
    parsers.parse('a V2 integration with type "{int_type}" was created'),
    target_fixture="v2_integration",
)
def a_v2_integration_was_created(int_type, v2_api, lws_invoke, e2e_port):
    result = lws_invoke(
        [
            "apigateway",
            "v2-create-integration",
            "--api-id",
            v2_api["apiId"],
            "--integration-type",
            int_type,
            "--port",
            str(e2e_port),
        ]
    )
    return {"integrationId": result["integrationId"]}


@given(
    parsers.parse('a V2 route with key "{route_key}" was created'),
    target_fixture="v2_route",
)
def a_v2_route_was_created(route_key, v2_api, lws_invoke, e2e_port):
    result = lws_invoke(
        [
            "apigateway",
            "v2-create-route",
            "--api-id",
            v2_api["apiId"],
            "--route-key",
            route_key,
            "--port",
            str(e2e_port),
        ]
    )
    return {"routeId": result["routeId"]}


@given(
    parsers.parse('a V2 stage named "{stage_name}" was created'),
)
def a_v2_stage_was_created(stage_name, v2_api, lws_invoke, e2e_port):
    lws_invoke(
        [
            "apigateway",
            "v2-create-stage",
            "--api-id",
            v2_api["apiId"],
            "--stage-name",
            stage_name,
            "--port",
            str(e2e_port),
        ]
    )


@when(
    "I create a deployment for the REST API",
    target_fixture="command_result",
)
def i_create_deployment(rest_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "create-deployment",
            "--rest-api-id",
            rest_api["id"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I create a resource with path part "{path_part}" under the root'),
    target_fixture="command_result",
)
def i_create_resource(path_part, rest_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "create-resource",
            "--rest-api-id",
            rest_api["id"],
            "--parent-id",
            rest_api["rootResourceId"],
            "--path-part",
            path_part,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I create a REST API named "{name}"'),
    target_fixture="command_result",
)
def i_create_rest_api(name, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "create-rest-api",
            "--name",
            name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I create a stage named "{stage_name}" for the REST API'),
    target_fixture="command_result",
)
def i_create_stage(stage_name, rest_api, deployment, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "create-stage",
            "--rest-api-id",
            rest_api["id"],
            "--stage-name",
            stage_name,
            "--deployment-id",
            deployment["id"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I create a V2 API named "{name}"'),
    target_fixture="command_result",
)
def i_create_v2_api(name, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "v2-create-api",
            "--name",
            name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I create a V2 integration with type "{int_type}"'),
    target_fixture="command_result",
)
def i_create_v2_integration(int_type, v2_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "v2-create-integration",
            "--api-id",
            v2_api["apiId"],
            "--integration-type",
            int_type,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I create a V2 route with key "{route_key}"'),
    target_fixture="command_result",
)
def i_create_v2_route(route_key, v2_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "v2-create-route",
            "--api-id",
            v2_api["apiId"],
            "--route-key",
            route_key,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I create a V2 stage named "{stage_name}"'),
    target_fixture="command_result",
)
def i_create_v2_stage(stage_name, v2_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "v2-create-stage",
            "--api-id",
            v2_api["apiId"],
            "--stage-name",
            stage_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete integration for method "{http_method}"'),
    target_fixture="command_result",
)
def i_delete_integration(http_method, rest_api, resource, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "delete-integration",
            "--rest-api-id",
            rest_api["id"],
            "--resource-id",
            resource["id"],
            "--http-method",
            http_method,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete method "{http_method}" on the resource'),
    target_fixture="command_result",
)
def i_delete_method(http_method, rest_api, resource, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "delete-method",
            "--rest-api-id",
            rest_api["id"],
            "--resource-id",
            resource["id"],
            "--http-method",
            http_method,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I delete the resource",
    target_fixture="command_result",
)
def i_delete_resource(rest_api, resource, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "delete-resource",
            "--rest-api-id",
            rest_api["id"],
            "--resource-id",
            resource["id"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I delete the REST API",
    target_fixture="command_result",
)
def i_delete_rest_api(rest_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "delete-rest-api",
            "--rest-api-id",
            rest_api["id"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete stage "{stage_name}" for the REST API'),
    target_fixture="command_result",
)
def i_delete_stage(stage_name, rest_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "delete-stage",
            "--rest-api-id",
            rest_api["id"],
            "--stage-name",
            stage_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I delete the V2 API",
    target_fixture="command_result",
)
def i_delete_v2_api(v2_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "v2-delete-api",
            "--api-id",
            v2_api["apiId"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I delete the V2 integration",
    target_fixture="command_result",
)
def i_delete_v2_integration(v2_api, v2_integration, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "v2-delete-integration",
            "--api-id",
            v2_api["apiId"],
            "--integration-id",
            v2_integration["integrationId"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I delete the V2 route",
    target_fixture="command_result",
)
def i_delete_v2_route(v2_api, v2_route, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "v2-delete-route",
            "--api-id",
            v2_api["apiId"],
            "--route-id",
            v2_route["routeId"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete V2 stage "{stage_name}"'),
    target_fixture="command_result",
)
def i_delete_v2_stage(stage_name, v2_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "v2-delete-stage",
            "--api-id",
            v2_api["apiId"],
            "--stage-name",
            stage_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I get the deployment",
    target_fixture="command_result",
)
def i_get_deployment(rest_api, deployment, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "get-deployment",
            "--rest-api-id",
            rest_api["id"],
            "--deployment-id",
            deployment["id"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I get integration for method "{http_method}"'),
    target_fixture="command_result",
)
def i_get_integration(http_method, rest_api, resource, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "get-integration",
            "--rest-api-id",
            rest_api["id"],
            "--resource-id",
            resource["id"],
            "--http-method",
            http_method,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I get integration response with status "{status}" for method "{http_method}"'),
    target_fixture="command_result",
)
def i_get_integration_response(status, http_method, rest_api, resource, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "get-integration-response",
            "--rest-api-id",
            rest_api["id"],
            "--resource-id",
            resource["id"],
            "--http-method",
            http_method,
            "--status-code",
            status,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I get method "{http_method}" on the resource'),
    target_fixture="command_result",
)
def i_get_method(http_method, rest_api, resource, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "get-method",
            "--rest-api-id",
            rest_api["id"],
            "--resource-id",
            resource["id"],
            "--http-method",
            http_method,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I get method response with status "{status}" for method "{http_method}"'),
    target_fixture="command_result",
)
def i_get_method_response(status, http_method, rest_api, resource, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "get-method-response",
            "--rest-api-id",
            rest_api["id"],
            "--resource-id",
            resource["id"],
            "--http-method",
            http_method,
            "--status-code",
            status,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I get resources for the REST API",
    target_fixture="command_result",
)
def i_get_resources(rest_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "get-resources",
            "--rest-api-id",
            rest_api["id"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I get the REST API",
    target_fixture="command_result",
)
def i_get_rest_api(rest_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "get-rest-api",
            "--rest-api-id",
            rest_api["id"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I get stage "{stage_name}" for the REST API'),
    target_fixture="command_result",
)
def i_get_stage(stage_name, rest_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "get-stage",
            "--rest-api-id",
            rest_api["id"],
            "--stage-name",
            stage_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I get the V2 API",
    target_fixture="command_result",
)
def i_get_v2_api(v2_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "v2-get-api",
            "--api-id",
            v2_api["apiId"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I get the V2 integration",
    target_fixture="command_result",
)
def i_get_v2_integration(v2_api, v2_integration, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "v2-get-integration",
            "--api-id",
            v2_api["apiId"],
            "--integration-id",
            v2_integration["integrationId"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I get the V2 route",
    target_fixture="command_result",
)
def i_get_v2_route(v2_api, v2_route, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "v2-get-route",
            "--api-id",
            v2_api["apiId"],
            "--route-id",
            v2_route["routeId"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I get V2 stage "{stage_name}"'),
    target_fixture="command_result",
)
def i_get_v2_stage(stage_name, v2_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "v2-get-stage",
            "--api-id",
            v2_api["apiId"],
            "--stage-name",
            stage_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I list deployments for the REST API",
    target_fixture="command_result",
)
def i_list_deployments(rest_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "list-deployments",
            "--rest-api-id",
            rest_api["id"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I list REST APIs",
    target_fixture="command_result",
)
def i_list_rest_apis(e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "list-rest-apis",
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I list V2 APIs",
    target_fixture="command_result",
)
def i_list_v2_apis(e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "v2-list-apis",
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I list V2 integrations",
    target_fixture="command_result",
)
def i_list_v2_integrations(v2_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "v2-list-integrations",
            "--api-id",
            v2_api["apiId"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I list V2 routes",
    target_fixture="command_result",
)
def i_list_v2_routes(v2_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "v2-list-routes",
            "--api-id",
            v2_api["apiId"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I list V2 stages",
    target_fixture="command_result",
)
def i_list_v2_stages(v2_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "v2-list-stages",
            "--api-id",
            v2_api["apiId"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I put integration type "{int_type}" on method "{http_method}"'),
    target_fixture="command_result",
)
def i_put_integration(int_type, http_method, rest_api, resource, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "put-integration",
            "--rest-api-id",
            rest_api["id"],
            "--resource-id",
            resource["id"],
            "--http-method",
            http_method,
            "--type",
            int_type,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I put integration response with status "{status}" on method "{http_method}"'),
    target_fixture="command_result",
)
def i_put_integration_response(status, http_method, rest_api, resource, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "put-integration-response",
            "--rest-api-id",
            rest_api["id"],
            "--resource-id",
            resource["id"],
            "--http-method",
            http_method,
            "--status-code",
            status,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I put method "{http_method}" on the resource'),
    target_fixture="command_result",
)
def i_put_method(http_method, rest_api, resource, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "put-method",
            "--rest-api-id",
            rest_api["id"],
            "--resource-id",
            resource["id"],
            "--http-method",
            http_method,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I put method response with status "{status}" on method "{http_method}"'),
    target_fixture="command_result",
)
def i_put_method_response(status, http_method, rest_api, resource, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "put-method-response",
            "--rest-api-id",
            rest_api["id"],
            "--resource-id",
            resource["id"],
            "--http-method",
            http_method,
            "--status-code",
            status,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I test invoke method "{http_method}" on resource "{resource_path}"'),
    target_fixture="command_result",
)
def i_test_invoke_method(http_method, resource_path, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "test-invoke-method",
            "--resource",
            resource_path,
            "--http-method",
            http_method,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I update the REST API name to "{new_name}"'),
    target_fixture="command_result",
)
def i_update_rest_api(new_name, rest_api, e2e_port):
    patch_ops = json.dumps([{"op": "replace", "path": "/name", "value": new_name}])
    return runner.invoke(
        app,
        [
            "apigateway",
            "update-rest-api",
            "--rest-api-id",
            rest_api["id"],
            "--patch-operations",
            patch_ops,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I update stage "{stage_name}" for the REST API'),
    target_fixture="command_result",
)
def i_update_stage(stage_name, rest_api, e2e_port):
    patch_ops = json.dumps([])
    return runner.invoke(
        app,
        [
            "apigateway",
            "update-stage",
            "--rest-api-id",
            rest_api["id"],
            "--stage-name",
            stage_name,
            "--patch-operations",
            patch_ops,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I update the V2 API name to "{new_name}"'),
    target_fixture="command_result",
)
def i_update_v2_api(new_name, v2_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "v2-update-api",
            "--api-id",
            v2_api["apiId"],
            "--name",
            new_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I update V2 stage "{stage_name}"'),
    target_fixture="command_result",
)
def i_update_v2_stage(stage_name, v2_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "v2-update-stage",
            "--api-id",
            v2_api["apiId"],
            "--stage-name",
            stage_name,
            "--port",
            str(e2e_port),
        ],
    )


@given(
    parsers.parse(
        'integration response with status "{status}" was added to method "{http_method}"'
    ),
)
def integration_response_was_added(status, http_method, rest_api, resource, lws_invoke, e2e_port):
    lws_invoke(
        [
            "apigateway",
            "put-integration-response",
            "--rest-api-id",
            rest_api["id"],
            "--resource-id",
            resource["id"],
            "--http-method",
            http_method,
            "--status-code",
            status,
            "--port",
            str(e2e_port),
        ]
    )


@given(
    parsers.parse('integration type "{int_type}" was added to method "{http_method}"'),
)
def integration_was_added(int_type, http_method, rest_api, resource, lws_invoke, e2e_port):
    lws_invoke(
        [
            "apigateway",
            "put-integration",
            "--rest-api-id",
            rest_api["id"],
            "--resource-id",
            resource["id"],
            "--http-method",
            http_method,
            "--type",
            int_type,
            "--port",
            str(e2e_port),
        ]
    )


@given(
    parsers.parse('method response with status "{status}" was added to method "{http_method}"'),
)
def method_response_was_added(status, http_method, rest_api, resource, lws_invoke, e2e_port):
    lws_invoke(
        [
            "apigateway",
            "put-method-response",
            "--rest-api-id",
            rest_api["id"],
            "--resource-id",
            resource["id"],
            "--http-method",
            http_method,
            "--status-code",
            status,
            "--port",
            str(e2e_port),
        ]
    )


@given(
    parsers.parse('method "{http_method}" was added to the resource'),
)
def method_was_added(http_method, rest_api, resource, lws_invoke, e2e_port):
    lws_invoke(
        [
            "apigateway",
            "put-method",
            "--rest-api-id",
            rest_api["id"],
            "--resource-id",
            resource["id"],
            "--http-method",
            http_method,
            "--port",
            str(e2e_port),
        ]
    )


@then(
    parsers.parse('the output "{field}" will be "{expected_value}"'),
)
def the_output_field_will_be(field, expected_value, command_result, parse_output):
    body = parse_output(command_result.output)
    actual_value = body[field]
    assert actual_value == expected_value


@then(
    'the output "id" will match the deployment ID',
)
def the_output_id_will_match_deployment(command_result, deployment, parse_output):
    body = parse_output(command_result.output)
    expected_id = deployment["id"]
    actual_id = body["id"]
    assert actual_id == expected_id


@then(
    parsers.parse('the output will contain a "{field}" field'),
)
def the_output_will_contain_a_field(field, command_result, parse_output):
    body = parse_output(command_result.output)
    assert field in body


@then(
    parsers.parse('the output will contain an "{field}" field'),
)
def the_output_will_contain_field(field, command_result, parse_output):
    body = parse_output(command_result.output)
    assert field in body


@then(
    parsers.parse('the output will contain an "{field}" list'),
)
def the_output_will_contain_list(field, command_result, parse_output):
    body = parse_output(command_result.output)
    assert field in body


@then(
    parsers.parse('the output will contain an "{field}" list with at least {count:d} entry'),
)
def the_output_will_contain_list_with_entries(field, count, command_result, parse_output):
    body = parse_output(command_result.output)
    assert field in body
    assert len(body[field]) >= count


@then(
    'the output "integrationId" will match the integration ID',
)
def the_output_will_match_integration_id(command_result, v2_integration, parse_output):
    body = parse_output(command_result.output)
    expected_id = v2_integration["integrationId"]
    actual_id = body["integrationId"]
    assert actual_id == expected_id


# ── Authorizer step definitions ──────────────────────────────────────


@given(
    parsers.parse('an authorizer "{name}" of type "{auth_type}" was created for the REST API'),
    target_fixture="authorizer",
)
def an_authorizer_was_created(name, auth_type, rest_api, lws_invoke, e2e_port):
    result = lws_invoke(
        [
            "apigateway",
            "create-authorizer",
            "--rest-api-id",
            rest_api["id"],
            "--name",
            name,
            "--type",
            auth_type,
            "--port",
            str(e2e_port),
        ]
    )
    return {"id": result["id"], "name": name}


@given(
    parsers.parse('a V2 authorizer "{name}" of type "{auth_type}" was created for the HTTP API'),
    target_fixture="v2_authorizer",
)
def a_v2_authorizer_was_created(name, auth_type, v2_api, lws_invoke, e2e_port):
    result = lws_invoke(
        [
            "apigateway",
            "v2-create-authorizer",
            "--api-id",
            v2_api["apiId"],
            "--name",
            name,
            "--authorizer-type",
            auth_type,
            "--port",
            str(e2e_port),
        ]
    )
    return {"authorizerId": result["authorizerId"], "name": name}


@when(
    parsers.parse('I create an authorizer named "{name}" of type "{auth_type}" for the REST API'),
    target_fixture="command_result",
)
def i_create_authorizer(name, auth_type, rest_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "create-authorizer",
            "--rest-api-id",
            rest_api["id"],
            "--name",
            name,
            "--type",
            auth_type,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I get the authorizer",
    target_fixture="command_result",
)
def i_get_authorizer(rest_api, authorizer, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "get-authorizer",
            "--rest-api-id",
            rest_api["id"],
            "--authorizer-id",
            authorizer["id"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I list authorizers for the REST API",
    target_fixture="command_result",
)
def i_list_authorizers(rest_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "get-authorizers",
            "--rest-api-id",
            rest_api["id"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I delete the authorizer",
    target_fixture="command_result",
)
def i_delete_authorizer(rest_api, authorizer, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "delete-authorizer",
            "--rest-api-id",
            rest_api["id"],
            "--authorizer-id",
            authorizer["id"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I create a V2 authorizer named "{name}" of type "{auth_type}" for the HTTP API'),
    target_fixture="command_result",
)
def i_create_v2_authorizer(name, auth_type, v2_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "v2-create-authorizer",
            "--api-id",
            v2_api["apiId"],
            "--name",
            name,
            "--authorizer-type",
            auth_type,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I get the V2 authorizer",
    target_fixture="command_result",
)
def i_get_v2_authorizer(v2_api, v2_authorizer, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "v2-get-authorizer",
            "--api-id",
            v2_api["apiId"],
            "--authorizer-id",
            v2_authorizer["authorizerId"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I list V2 authorizers",
    target_fixture="command_result",
)
def i_list_v2_authorizers(v2_api, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "v2-get-authorizers",
            "--api-id",
            v2_api["apiId"],
            "--port",
            str(e2e_port),
        ],
    )


@when(
    "I delete the V2 authorizer",
    target_fixture="command_result",
)
def i_delete_v2_authorizer(v2_api, v2_authorizer, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "v2-delete-authorizer",
            "--api-id",
            v2_api["apiId"],
            "--authorizer-id",
            v2_authorizer["authorizerId"],
            "--port",
            str(e2e_port),
        ],
    )


# ── CORS, multi-value, binary step definitions ──────────────────────


@given(
    parsers.parse('an echo Lambda "{name}" was created'),
    target_fixture="echo_lambda",
)
def an_echo_lambda_was_created(name, echo_handler_dir, lws_invoke, e2e_port):
    lws_invoke(
        [
            "lambda",
            "create-function",
            "--function-name",
            name,
            "--runtime",
            "python3.12",
            "--handler",
            "handler.handler",
            "--code",
            json.dumps({"Filename": echo_handler_dir}),
            "--timeout",
            "30",
            "--port",
            str(e2e_port),
        ]
    )
    return {"name": name}


@given(
    parsers.parse('a V2 API "{name}" was created with CORS allowing all origins'),
    target_fixture="v2_api",
)
def a_v2_api_with_cors_was_created(name, lws_invoke, e2e_port):
    cors = json.dumps({"allowOrigins": ["*"], "allowMethods": ["GET", "POST"]})
    result = lws_invoke(
        [
            "apigateway",
            "v2-create-api",
            "--name",
            name,
            "--cors-configuration",
            cors,
            "--port",
            str(e2e_port),
        ]
    )
    return {"apiId": result["apiId"], "name": name}


@given(
    parsers.parse('a V2 proxy integration for Lambda "{func_name}" was created'),
    target_fixture="v2_integration",
)
def a_v2_proxy_integration_was_created(func_name, v2_api, lws_invoke, e2e_port):
    uri = f"arn:aws:lambda:us-east-1:000:function:{func_name}"
    result = lws_invoke(
        [
            "apigateway",
            "v2-create-integration",
            "--api-id",
            v2_api["apiId"],
            "--integration-type",
            "AWS_PROXY",
            "--integration-uri",
            uri,
            "--port",
            str(e2e_port),
        ]
    )
    return {"integrationId": result["integrationId"]}


@when(
    parsers.parse('I create a V2 API named "{name}" with CORS allowing all origins'),
    target_fixture="command_result",
)
def i_create_v2_api_with_cors(name, e2e_port):
    cors = json.dumps({"allowOrigins": ["*"], "allowMethods": ["GET", "POST"]})
    return runner.invoke(
        app,
        [
            "apigateway",
            "v2-create-api",
            "--name",
            name,
            "--cors-configuration",
            cors,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I test invoke OPTIONS on "{resource}" with origin "{origin}"'),
    target_fixture="command_result",
)
def i_test_invoke_options(resource, origin, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "test-invoke-method",
            "--resource",
            resource,
            "--http-method",
            "OPTIONS",
            "--header",
            f"Origin:{origin}",
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I test invoke GET on "{resource}"'),
    target_fixture="command_result",
)
def i_test_invoke_get(resource, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "test-invoke-method",
            "--resource",
            resource,
            "--http-method",
            "GET",
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I test invoke GET on "{resource}" with header "{hdr}"'),
    target_fixture="command_result",
)
def i_test_invoke_get_with_header(resource, hdr, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "test-invoke-method",
            "--resource",
            resource,
            "--http-method",
            "GET",
            "--header",
            hdr,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I test invoke POST on "{resource}" with binary content type'),
    target_fixture="command_result",
)
def i_test_invoke_post_binary(resource, e2e_port):
    return runner.invoke(
        app,
        [
            "apigateway",
            "test-invoke-method",
            "--resource",
            resource,
            "--http-method",
            "POST",
            "--body",
            "binarydata",
            "--content-type",
            "application/octet-stream",
            "--port",
            str(e2e_port),
        ],
    )


@then(
    parsers.parse("the invoke response status will be {expected_status:d}"),
)
def the_invoke_response_status_will_be(expected_status, command_result, parse_output):
    body = parse_output(command_result.output)
    actual_status = body["status"]
    assert actual_status == expected_status


@then(
    parsers.parse('the invoke response header "{header}" will contain "{expected_value}"'),
)
def the_invoke_response_header_will_contain(header, expected_value, command_result, parse_output):
    body = parse_output(command_result.output)
    actual_headers = body["headers"]
    header_values = actual_headers.get(header, [])
    assert expected_value in header_values or expected_value in str(header_values)


@then(
    parsers.parse('the invoke response body field "{field_path}" will be "{expected_value}"'),
)
def the_invoke_response_body_field_will_be(
    field_path, expected_value, command_result, parse_output
):
    body = parse_output(command_result.output)
    resp_body = body["body"]
    if isinstance(resp_body, str):
        resp_body = json.loads(resp_body)
    parts = field_path.split(".")
    current = resp_body
    for part in parts:
        current = current[part]
    assert str(current) == expected_value
