"""``lws apigateway`` sub-commands."""

from __future__ import annotations

import asyncio
import json

import typer

from lws.cli.services.client import LwsClient, exit_with_error, output_json

app = typer.Typer(help="API Gateway commands")

_SERVICE = "apigateway"


def _client(port: int) -> LwsClient:
    return LwsClient(port=port)


# ---------------------------------------------------------------------------
# test-invoke-method (existing — uses httpx directly)
# ---------------------------------------------------------------------------


@app.command("test-invoke-method")
def test_invoke_method(
    rest_api_name: str = typer.Option("default", "--rest-api-name", help="REST API name"),
    resource: str = typer.Option(..., "--resource", help="Resource path (e.g. /orders)"),
    http_method: str = typer.Option(..., "--http-method", help="HTTP method (GET, POST, etc.)"),
    body: str = typer.Option(None, "--body", help="Request body (JSON string)"),
    header: list[str] = typer.Option(
        None, "--header", help="Request header as Key:Value (repeatable)"
    ),
    content_type: str = typer.Option(None, "--content-type", help="Content-Type header"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Invoke an API Gateway route."""
    asyncio.run(
        _test_invoke_method(
            rest_api_name, resource, http_method, body, header or [], content_type, port
        )
    )


async def _test_invoke_method(
    _rest_api_name: str,
    resource: str,
    http_method: str,
    body: str | None,
    extra_headers: list[str],
    content_type: str | None,
    port: int,
) -> None:
    client = _client(port)
    try:
        api_port = await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))

    import httpx  # pylint: disable=import-outside-toplevel

    request_body = body.encode() if body else None
    headers: list[tuple[str, str]] = []
    if content_type:
        headers.append(("Content-Type", content_type))
    elif body:
        headers.append(("Content-Type", "application/json"))
    for h in extra_headers:
        key, _, value = h.partition(":")
        headers.append((key.strip(), value.strip()))

    async with httpx.AsyncClient() as http_client:
        resp = await http_client.request(
            http_method.upper(),
            f"http://localhost:{api_port}{resource}",
            content=request_body,
            headers=headers,
            timeout=30.0,
        )

    # Try to parse response body as JSON, fall back to string
    try:
        resp_body = resp.json()
    except Exception:
        resp_body = resp.text

    # Collect all response header values (preserving multi-value)
    resp_headers: dict[str, list[str]] = {}
    for key, value in resp.headers.multi_items():
        resp_headers.setdefault(key, []).append(value)

    result = {
        "status": resp.status_code,
        "headers": resp_headers,
        "body": resp_body,
    }
    output_json(result)


# ---------------------------------------------------------------------------
# REST API (V1) management commands
# ---------------------------------------------------------------------------


@app.command("create-rest-api")
def create_rest_api(
    name: str = typer.Option(..., "--name", help="REST API name"),
    description: str = typer.Option("", "--description", help="REST API description"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a new REST API."""
    asyncio.run(_create_rest_api(name, description, port))


async def _create_rest_api(name: str, description: str, port: int) -> None:
    client = _client(port)
    json_body = json.dumps({"name": name, "description": description}).encode()
    try:
        resp = await client.rest_request(
            _SERVICE,
            "POST",
            "/restapis",
            body=json_body,
            headers={"Content-Type": "application/json"},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("list-rest-apis")
def list_rest_apis(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List all REST APIs."""
    asyncio.run(_list_rest_apis(port))


async def _list_rest_apis(port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(_SERVICE, "GET", "/restapis")
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("get-rest-api")
def get_rest_api(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get a REST API by ID."""
    asyncio.run(_get_rest_api(rest_api_id, port))


async def _get_rest_api(rest_api_id: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(_SERVICE, "GET", f"/restapis/{rest_api_id}")
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("update-rest-api")
def update_rest_api(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    patch_operations: str = typer.Option(
        ..., "--patch-operations", help="JSON array of patch operations"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Update a REST API."""
    asyncio.run(_update_rest_api(rest_api_id, patch_operations, port))


async def _update_rest_api(rest_api_id: str, patch_operations: str, port: int) -> None:
    client = _client(port)
    try:
        parsed = json.loads(patch_operations)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --patch-operations: {exc}")
    json_body = json.dumps({"patchOperations": parsed}).encode()
    try:
        resp = await client.rest_request(
            _SERVICE,
            "PATCH",
            f"/restapis/{rest_api_id}",
            body=json_body,
            headers={"Content-Type": "application/json"},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("delete-rest-api")
def delete_rest_api(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a REST API."""
    asyncio.run(_delete_rest_api(rest_api_id, port))


async def _delete_rest_api(rest_api_id: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(_SERVICE, "DELETE", f"/restapis/{rest_api_id}")
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json() if resp.content else {})


@app.command("get-resources")
def get_resources(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get resources for a REST API."""
    asyncio.run(_get_resources(rest_api_id, port))


async def _get_resources(rest_api_id: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "GET",
            f"/restapis/{rest_api_id}/resources",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("create-resource")
def create_resource(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    parent_id: str = typer.Option(..., "--parent-id", help="Parent resource ID"),
    path_part: str = typer.Option(..., "--path-part", help="Path part for the resource"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a resource under a parent resource."""
    asyncio.run(_create_resource(rest_api_id, parent_id, path_part, port))


async def _create_resource(rest_api_id: str, parent_id: str, path_part: str, port: int) -> None:
    client = _client(port)
    json_body = json.dumps({"pathPart": path_part}).encode()
    try:
        resp = await client.rest_request(
            _SERVICE,
            "POST",
            f"/restapis/{rest_api_id}/resources/{parent_id}",
            body=json_body,
            headers={"Content-Type": "application/json"},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("delete-resource")
def delete_resource(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    resource_id: str = typer.Option(..., "--resource-id", help="Resource ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a resource."""
    asyncio.run(_delete_resource(rest_api_id, resource_id, port))


async def _delete_resource(rest_api_id: str, resource_id: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "DELETE",
            f"/restapis/{rest_api_id}/resources/{resource_id}",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json() if resp.content else {})


@app.command("put-method")
def put_method(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    resource_id: str = typer.Option(..., "--resource-id", help="Resource ID"),
    http_method: str = typer.Option(..., "--http-method", help="HTTP method"),
    authorization_type: str = typer.Option(
        "NONE", "--authorization-type", help="Authorization type"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Add a method to a resource."""
    asyncio.run(_put_method(rest_api_id, resource_id, http_method, authorization_type, port))


async def _put_method(
    rest_api_id: str,
    resource_id: str,
    http_method: str,
    authorization_type: str,
    port: int,
) -> None:
    client = _client(port)
    json_body = json.dumps({"authorizationType": authorization_type}).encode()
    try:
        resp = await client.rest_request(
            _SERVICE,
            "PUT",
            f"/restapis/{rest_api_id}/resources/{resource_id}/methods/{http_method}",
            body=json_body,
            headers={"Content-Type": "application/json"},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("get-method")
def get_method(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    resource_id: str = typer.Option(..., "--resource-id", help="Resource ID"),
    http_method: str = typer.Option(..., "--http-method", help="HTTP method"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get a method on a resource."""
    asyncio.run(_get_method(rest_api_id, resource_id, http_method, port))


async def _get_method(rest_api_id: str, resource_id: str, http_method: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "GET",
            f"/restapis/{rest_api_id}/resources/{resource_id}/methods/{http_method}",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("delete-method")
def delete_method(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    resource_id: str = typer.Option(..., "--resource-id", help="Resource ID"),
    http_method: str = typer.Option(..., "--http-method", help="HTTP method"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a method from a resource."""
    asyncio.run(_delete_method(rest_api_id, resource_id, http_method, port))


async def _delete_method(rest_api_id: str, resource_id: str, http_method: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "DELETE",
            f"/restapis/{rest_api_id}/resources/{resource_id}/methods/{http_method}",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json() if resp.content else {})


@app.command("put-integration")
def put_integration(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    resource_id: str = typer.Option(..., "--resource-id", help="Resource ID"),
    http_method: str = typer.Option(..., "--http-method", help="HTTP method"),
    integration_type: str = typer.Option(..., "--type", help="Integration type"),
    integration_http_method: str = typer.Option(
        None, "--integration-http-method", help="Integration HTTP method"
    ),
    uri: str = typer.Option(None, "--uri", help="Integration URI"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Add an integration to a method."""
    asyncio.run(
        _put_integration(
            rest_api_id,
            resource_id,
            http_method,
            integration_type,
            integration_http_method,
            uri,
            port,
        )
    )


async def _put_integration(
    rest_api_id: str,
    resource_id: str,
    http_method: str,
    integration_type: str,
    integration_http_method: str | None,
    uri: str | None,
    port: int,
) -> None:
    client = _client(port)
    body: dict = {"type": integration_type}
    if integration_http_method:
        body["integrationHttpMethod"] = integration_http_method
    if uri:
        body["uri"] = uri
    json_body = json.dumps(body).encode()
    try:
        resp = await client.rest_request(
            _SERVICE,
            "PUT",
            f"/restapis/{rest_api_id}/resources/{resource_id}/methods/{http_method}/integration",
            body=json_body,
            headers={"Content-Type": "application/json"},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("get-integration")
def get_integration(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    resource_id: str = typer.Option(..., "--resource-id", help="Resource ID"),
    http_method: str = typer.Option(..., "--http-method", help="HTTP method"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get the integration for a method."""
    asyncio.run(_get_integration(rest_api_id, resource_id, http_method, port))


async def _get_integration(rest_api_id: str, resource_id: str, http_method: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "GET",
            f"/restapis/{rest_api_id}/resources/{resource_id}/methods/{http_method}/integration",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("delete-integration")
def delete_integration(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    resource_id: str = typer.Option(..., "--resource-id", help="Resource ID"),
    http_method: str = typer.Option(..., "--http-method", help="HTTP method"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete the integration for a method."""
    asyncio.run(_delete_integration(rest_api_id, resource_id, http_method, port))


async def _delete_integration(
    rest_api_id: str, resource_id: str, http_method: str, port: int
) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "DELETE",
            f"/restapis/{rest_api_id}/resources/{resource_id}/methods/{http_method}/integration",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json() if resp.content else {})


@app.command("put-integration-response")
def put_integration_response(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    resource_id: str = typer.Option(..., "--resource-id", help="Resource ID"),
    http_method: str = typer.Option(..., "--http-method", help="HTTP method"),
    status_code: str = typer.Option(..., "--status-code", help="Status code"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Add an integration response."""
    asyncio.run(_put_integration_response(rest_api_id, resource_id, http_method, status_code, port))


async def _put_integration_response(
    rest_api_id: str,
    resource_id: str,
    http_method: str,
    status_code: str,
    port: int,
) -> None:
    client = _client(port)
    json_body = json.dumps({"statusCode": status_code}).encode()
    try:
        resp = await client.rest_request(
            _SERVICE,
            "PUT",
            f"/restapis/{rest_api_id}/resources/{resource_id}"
            f"/methods/{http_method}/integration/responses/{status_code}",
            body=json_body,
            headers={"Content-Type": "application/json"},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("get-integration-response")
def get_integration_response(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    resource_id: str = typer.Option(..., "--resource-id", help="Resource ID"),
    http_method: str = typer.Option(..., "--http-method", help="HTTP method"),
    status_code: str = typer.Option(..., "--status-code", help="Status code"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get an integration response."""
    asyncio.run(_get_integration_response(rest_api_id, resource_id, http_method, status_code, port))


async def _get_integration_response(
    rest_api_id: str,
    resource_id: str,
    http_method: str,
    status_code: str,
    port: int,
) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "GET",
            f"/restapis/{rest_api_id}/resources/{resource_id}"
            f"/methods/{http_method}/integration/responses/{status_code}",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("put-method-response")
def put_method_response(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    resource_id: str = typer.Option(..., "--resource-id", help="Resource ID"),
    http_method: str = typer.Option(..., "--http-method", help="HTTP method"),
    status_code: str = typer.Option(..., "--status-code", help="Status code"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Add a method response."""
    asyncio.run(_put_method_response(rest_api_id, resource_id, http_method, status_code, port))


async def _put_method_response(
    rest_api_id: str,
    resource_id: str,
    http_method: str,
    status_code: str,
    port: int,
) -> None:
    client = _client(port)
    json_body = json.dumps({"statusCode": status_code}).encode()
    try:
        resp = await client.rest_request(
            _SERVICE,
            "PUT",
            f"/restapis/{rest_api_id}/resources/{resource_id}"
            f"/methods/{http_method}/responses/{status_code}",
            body=json_body,
            headers={"Content-Type": "application/json"},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("get-method-response")
def get_method_response(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    resource_id: str = typer.Option(..., "--resource-id", help="Resource ID"),
    http_method: str = typer.Option(..., "--http-method", help="HTTP method"),
    status_code: str = typer.Option(..., "--status-code", help="Status code"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get a method response."""
    asyncio.run(_get_method_response(rest_api_id, resource_id, http_method, status_code, port))


async def _get_method_response(
    rest_api_id: str,
    resource_id: str,
    http_method: str,
    status_code: str,
    port: int,
) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "GET",
            f"/restapis/{rest_api_id}/resources/{resource_id}"
            f"/methods/{http_method}/responses/{status_code}",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("create-deployment")
def create_deployment(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    stage_name: str = typer.Option(None, "--stage-name", help="Stage name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a deployment for a REST API."""
    asyncio.run(_create_deployment(rest_api_id, stage_name, port))


async def _create_deployment(rest_api_id: str, stage_name: str | None, port: int) -> None:
    client = _client(port)
    body: dict = {}
    if stage_name:
        body["stageName"] = stage_name
    json_body = json.dumps(body).encode()
    try:
        resp = await client.rest_request(
            _SERVICE,
            "POST",
            f"/restapis/{rest_api_id}/deployments",
            body=json_body,
            headers={"Content-Type": "application/json"},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("list-deployments")
def list_deployments(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List deployments for a REST API."""
    asyncio.run(_list_deployments(rest_api_id, port))


async def _list_deployments(rest_api_id: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "GET",
            f"/restapis/{rest_api_id}/deployments",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("get-deployment")
def get_deployment(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    deployment_id: str = typer.Option(..., "--deployment-id", help="Deployment ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get a deployment by ID."""
    asyncio.run(_get_deployment(rest_api_id, deployment_id, port))


async def _get_deployment(rest_api_id: str, deployment_id: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "GET",
            f"/restapis/{rest_api_id}/deployments/{deployment_id}",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("create-stage")
def create_stage(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    stage_name: str = typer.Option(..., "--stage-name", help="Stage name"),
    deployment_id: str = typer.Option(..., "--deployment-id", help="Deployment ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a stage for a REST API."""
    asyncio.run(_create_stage(rest_api_id, stage_name, deployment_id, port))


async def _create_stage(rest_api_id: str, stage_name: str, deployment_id: str, port: int) -> None:
    client = _client(port)
    json_body = json.dumps({"stageName": stage_name, "deploymentId": deployment_id}).encode()
    try:
        resp = await client.rest_request(
            _SERVICE,
            "POST",
            f"/restapis/{rest_api_id}/stages",
            body=json_body,
            headers={"Content-Type": "application/json"},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("get-stage")
def get_stage(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    stage_name: str = typer.Option(..., "--stage-name", help="Stage name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get a stage by name."""
    asyncio.run(_get_stage(rest_api_id, stage_name, port))


async def _get_stage(rest_api_id: str, stage_name: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "GET",
            f"/restapis/{rest_api_id}/stages/{stage_name}",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("update-stage")
def update_stage(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    stage_name: str = typer.Option(..., "--stage-name", help="Stage name"),
    patch_operations: str = typer.Option(
        ..., "--patch-operations", help="JSON array of patch operations"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Update a stage."""
    asyncio.run(_update_stage(rest_api_id, stage_name, patch_operations, port))


async def _update_stage(
    rest_api_id: str, stage_name: str, patch_operations: str, port: int
) -> None:
    client = _client(port)
    try:
        parsed = json.loads(patch_operations)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --patch-operations: {exc}")
    json_body = json.dumps({"patchOperations": parsed}).encode()
    try:
        resp = await client.rest_request(
            _SERVICE,
            "PATCH",
            f"/restapis/{rest_api_id}/stages/{stage_name}",
            body=json_body,
            headers={"Content-Type": "application/json"},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("delete-stage")
def delete_stage(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    stage_name: str = typer.Option(..., "--stage-name", help="Stage name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a stage."""
    asyncio.run(_delete_stage(rest_api_id, stage_name, port))


async def _delete_stage(rest_api_id: str, stage_name: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "DELETE",
            f"/restapis/{rest_api_id}/stages/{stage_name}",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json() if resp.content else {})


# ---------------------------------------------------------------------------
# HTTP API (V2) management commands
# ---------------------------------------------------------------------------


@app.command("v2-create-api")
def v2_create_api(
    name: str = typer.Option(..., "--name", help="API name"),
    protocol_type: str = typer.Option("HTTP", "--protocol-type", help="Protocol type"),
    cors_configuration: str = typer.Option(
        None, "--cors-configuration", help="JSON CORS configuration"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a new HTTP API (V2)."""
    asyncio.run(_v2_create_api(name, protocol_type, cors_configuration, port))


async def _v2_create_api(
    name: str, protocol_type: str, cors_configuration: str | None, port: int
) -> None:
    client = _client(port)
    body: dict = {"Name": name, "ProtocolType": protocol_type}
    if cors_configuration:
        body["CorsConfiguration"] = json.loads(cors_configuration)
    json_body = json.dumps(body).encode()
    try:
        resp = await client.rest_request(
            _SERVICE,
            "POST",
            "/v2/apis",
            body=json_body,
            headers={"Content-Type": "application/json"},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("v2-list-apis")
def v2_list_apis(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List all HTTP APIs (V2)."""
    asyncio.run(_v2_list_apis(port))


async def _v2_list_apis(port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(_SERVICE, "GET", "/v2/apis")
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("v2-get-api")
def v2_get_api(
    api_id: str = typer.Option(..., "--api-id", help="API ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get an HTTP API (V2) by ID."""
    asyncio.run(_v2_get_api(api_id, port))


async def _v2_get_api(api_id: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(_SERVICE, "GET", f"/v2/apis/{api_id}")
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("v2-update-api")
def v2_update_api(
    api_id: str = typer.Option(..., "--api-id", help="API ID"),
    name: str = typer.Option(None, "--name", help="New API name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Update an HTTP API (V2)."""
    asyncio.run(_v2_update_api(api_id, name, port))


async def _v2_update_api(api_id: str, name: str | None, port: int) -> None:
    client = _client(port)
    body: dict = {}
    if name:
        body["Name"] = name
    json_body = json.dumps(body).encode()
    try:
        resp = await client.rest_request(
            _SERVICE,
            "PATCH",
            f"/v2/apis/{api_id}",
            body=json_body,
            headers={"Content-Type": "application/json"},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("v2-delete-api")
def v2_delete_api(
    api_id: str = typer.Option(..., "--api-id", help="API ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete an HTTP API (V2)."""
    asyncio.run(_v2_delete_api(api_id, port))


async def _v2_delete_api(api_id: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(_SERVICE, "DELETE", f"/v2/apis/{api_id}")
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json() if resp.content else {})


@app.command("v2-create-stage")
def v2_create_stage(
    api_id: str = typer.Option(..., "--api-id", help="API ID"),
    stage_name: str = typer.Option(..., "--stage-name", help="Stage name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a stage for an HTTP API (V2)."""
    asyncio.run(_v2_create_stage(api_id, stage_name, port))


async def _v2_create_stage(api_id: str, stage_name: str, port: int) -> None:
    client = _client(port)
    json_body = json.dumps({"StageName": stage_name}).encode()
    try:
        resp = await client.rest_request(
            _SERVICE,
            "POST",
            f"/v2/apis/{api_id}/stages",
            body=json_body,
            headers={"Content-Type": "application/json"},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("v2-get-stage")
def v2_get_stage(
    api_id: str = typer.Option(..., "--api-id", help="API ID"),
    stage_name: str = typer.Option(..., "--stage-name", help="Stage name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get a stage for an HTTP API (V2)."""
    asyncio.run(_v2_get_stage(api_id, stage_name, port))


async def _v2_get_stage(api_id: str, stage_name: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "GET",
            f"/v2/apis/{api_id}/stages/{stage_name}",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("v2-update-stage")
def v2_update_stage(
    api_id: str = typer.Option(..., "--api-id", help="API ID"),
    stage_name: str = typer.Option(..., "--stage-name", help="Stage name"),
    patch_operations: str = typer.Option(
        None, "--patch-operations", help="JSON array of patch operations"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Update a stage for an HTTP API (V2)."""
    asyncio.run(_v2_update_stage(api_id, stage_name, patch_operations, port))


async def _v2_update_stage(
    api_id: str, stage_name: str, patch_operations: str | None, port: int
) -> None:
    client = _client(port)
    body: dict = {}
    if patch_operations:
        try:
            body["patchOperations"] = json.loads(patch_operations)
        except json.JSONDecodeError as exc:
            exit_with_error(f"Invalid JSON in --patch-operations: {exc}")
    json_body = json.dumps(body).encode()
    try:
        resp = await client.rest_request(
            _SERVICE,
            "PATCH",
            f"/v2/apis/{api_id}/stages/{stage_name}",
            body=json_body,
            headers={"Content-Type": "application/json"},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("v2-delete-stage")
def v2_delete_stage(
    api_id: str = typer.Option(..., "--api-id", help="API ID"),
    stage_name: str = typer.Option(..., "--stage-name", help="Stage name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a stage for an HTTP API (V2)."""
    asyncio.run(_v2_delete_stage(api_id, stage_name, port))


async def _v2_delete_stage(api_id: str, stage_name: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "DELETE",
            f"/v2/apis/{api_id}/stages/{stage_name}",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json() if resp.content else {})


@app.command("v2-list-stages")
def v2_list_stages(
    api_id: str = typer.Option(..., "--api-id", help="API ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List stages for an HTTP API (V2)."""
    asyncio.run(_v2_list_stages(api_id, port))


async def _v2_list_stages(api_id: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(_SERVICE, "GET", f"/v2/apis/{api_id}/stages")
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("v2-create-integration")
def v2_create_integration(
    api_id: str = typer.Option(..., "--api-id", help="API ID"),
    integration_type: str = typer.Option(..., "--integration-type", help="Integration type"),
    integration_uri: str = typer.Option(None, "--integration-uri", help="Integration URI"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create an integration for an HTTP API (V2)."""
    asyncio.run(_v2_create_integration(api_id, integration_type, integration_uri, port))


async def _v2_create_integration(
    api_id: str, integration_type: str, integration_uri: str | None, port: int
) -> None:
    client = _client(port)
    body: dict = {"IntegrationType": integration_type}
    if integration_uri:
        body["IntegrationUri"] = integration_uri
    json_body = json.dumps(body).encode()
    try:
        resp = await client.rest_request(
            _SERVICE,
            "POST",
            f"/v2/apis/{api_id}/integrations",
            body=json_body,
            headers={"Content-Type": "application/json"},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("v2-list-integrations")
def v2_list_integrations(
    api_id: str = typer.Option(..., "--api-id", help="API ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List integrations for an HTTP API (V2)."""
    asyncio.run(_v2_list_integrations(api_id, port))


async def _v2_list_integrations(api_id: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "GET",
            f"/v2/apis/{api_id}/integrations",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("v2-get-integration")
def v2_get_integration(
    api_id: str = typer.Option(..., "--api-id", help="API ID"),
    integration_id: str = typer.Option(..., "--integration-id", help="Integration ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get an integration for an HTTP API (V2)."""
    asyncio.run(_v2_get_integration(api_id, integration_id, port))


async def _v2_get_integration(api_id: str, integration_id: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "GET",
            f"/v2/apis/{api_id}/integrations/{integration_id}",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("v2-delete-integration")
def v2_delete_integration(
    api_id: str = typer.Option(..., "--api-id", help="API ID"),
    integration_id: str = typer.Option(..., "--integration-id", help="Integration ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete an integration for an HTTP API (V2)."""
    asyncio.run(_v2_delete_integration(api_id, integration_id, port))


async def _v2_delete_integration(api_id: str, integration_id: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "DELETE",
            f"/v2/apis/{api_id}/integrations/{integration_id}",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json() if resp.content else {})


@app.command("v2-create-route")
def v2_create_route(
    api_id: str = typer.Option(..., "--api-id", help="API ID"),
    route_key: str = typer.Option(..., "--route-key", help="Route key (e.g. GET /items)"),
    target: str = typer.Option(None, "--target", help="Integration target"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a route for an HTTP API (V2)."""
    asyncio.run(_v2_create_route(api_id, route_key, target, port))


async def _v2_create_route(api_id: str, route_key: str, target: str | None, port: int) -> None:
    client = _client(port)
    body: dict = {"RouteKey": route_key}
    if target:
        body["Target"] = target
    json_body = json.dumps(body).encode()
    try:
        resp = await client.rest_request(
            _SERVICE,
            "POST",
            f"/v2/apis/{api_id}/routes",
            body=json_body,
            headers={"Content-Type": "application/json"},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("v2-list-routes")
def v2_list_routes(
    api_id: str = typer.Option(..., "--api-id", help="API ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List routes for an HTTP API (V2)."""
    asyncio.run(_v2_list_routes(api_id, port))


async def _v2_list_routes(api_id: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(_SERVICE, "GET", f"/v2/apis/{api_id}/routes")
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("v2-get-route")
def v2_get_route(
    api_id: str = typer.Option(..., "--api-id", help="API ID"),
    route_id: str = typer.Option(..., "--route-id", help="Route ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get a route for an HTTP API (V2)."""
    asyncio.run(_v2_get_route(api_id, route_id, port))


async def _v2_get_route(api_id: str, route_id: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "GET",
            f"/v2/apis/{api_id}/routes/{route_id}",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("v2-delete-route")
def v2_delete_route(
    api_id: str = typer.Option(..., "--api-id", help="API ID"),
    route_id: str = typer.Option(..., "--route-id", help="Route ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a route for an HTTP API (V2)."""
    asyncio.run(_v2_delete_route(api_id, route_id, port))


async def _v2_delete_route(api_id: str, route_id: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "DELETE",
            f"/v2/apis/{api_id}/routes/{route_id}",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json() if resp.content else {})


# ---------------------------------------------------------------------------
# REST API (V1) Authorizer commands
# ---------------------------------------------------------------------------


@app.command("create-authorizer")
def create_authorizer(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    name: str = typer.Option(..., "--name", help="Authorizer name"),
    authorizer_type: str = typer.Option(..., "--type", help="Authorizer type"),
    provider_arns: str = typer.Option(None, "--provider-arns", help="JSON array of provider ARNs"),
    authorizer_uri: str = typer.Option(None, "--authorizer-uri", help="Authorizer URI"),
    identity_source: str = typer.Option(None, "--identity-source", help="Identity source"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create an authorizer for a REST API."""
    asyncio.run(
        _create_authorizer(
            rest_api_id, name, authorizer_type, provider_arns, authorizer_uri, identity_source, port
        )
    )


async def _create_authorizer(
    rest_api_id: str,
    name: str,
    authorizer_type: str,
    provider_arns: str | None,
    authorizer_uri: str | None,
    identity_source: str | None,
    port: int,
) -> None:
    client = _client(port)
    body: dict = {"name": name, "type": authorizer_type}
    if provider_arns:
        body["providerARNs"] = json.loads(provider_arns)
    if authorizer_uri:
        body["authorizerUri"] = authorizer_uri
    if identity_source:
        body["identitySource"] = identity_source
    json_body = json.dumps(body).encode()
    try:
        resp = await client.rest_request(
            _SERVICE,
            "POST",
            f"/restapis/{rest_api_id}/authorizers",
            body=json_body,
            headers={"Content-Type": "application/json"},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("get-authorizers")
def get_authorizers(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List authorizers for a REST API."""
    asyncio.run(_get_authorizers(rest_api_id, port))


async def _get_authorizers(rest_api_id: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "GET",
            f"/restapis/{rest_api_id}/authorizers",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("get-authorizer")
def get_authorizer(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    authorizer_id: str = typer.Option(..., "--authorizer-id", help="Authorizer ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get an authorizer by ID."""
    asyncio.run(_get_authorizer(rest_api_id, authorizer_id, port))


async def _get_authorizer(rest_api_id: str, authorizer_id: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "GET",
            f"/restapis/{rest_api_id}/authorizers/{authorizer_id}",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("delete-authorizer")
def delete_authorizer(
    rest_api_id: str = typer.Option(..., "--rest-api-id", help="REST API ID"),
    authorizer_id: str = typer.Option(..., "--authorizer-id", help="Authorizer ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete an authorizer."""
    asyncio.run(_delete_authorizer(rest_api_id, authorizer_id, port))


async def _delete_authorizer(rest_api_id: str, authorizer_id: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "DELETE",
            f"/restapis/{rest_api_id}/authorizers/{authorizer_id}",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json() if resp.content else {})


# ---------------------------------------------------------------------------
# HTTP API (V2) Authorizer commands
# ---------------------------------------------------------------------------


@app.command("v2-create-authorizer")
def v2_create_authorizer(
    api_id: str = typer.Option(..., "--api-id", help="API ID"),
    name: str = typer.Option(..., "--name", help="Authorizer name"),
    authorizer_type: str = typer.Option(..., "--authorizer-type", help="Authorizer type"),
    identity_source: str = typer.Option(None, "--identity-source", help="Identity source"),
    jwt_configuration: str = typer.Option(
        None, "--jwt-configuration", help="JSON JWT configuration"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create an authorizer for an HTTP API (V2)."""
    asyncio.run(
        _v2_create_authorizer(
            api_id, name, authorizer_type, identity_source, jwt_configuration, port
        )
    )


async def _v2_create_authorizer(
    api_id: str,
    name: str,
    authorizer_type: str,
    identity_source: str | None,
    jwt_configuration: str | None,
    port: int,
) -> None:
    client = _client(port)
    body: dict = {"Name": name, "AuthorizerType": authorizer_type}
    if identity_source:
        body["IdentitySource"] = identity_source
    if jwt_configuration:
        body["JwtConfiguration"] = json.loads(jwt_configuration)
    json_body = json.dumps(body).encode()
    try:
        resp = await client.rest_request(
            _SERVICE,
            "POST",
            f"/v2/apis/{api_id}/authorizers",
            body=json_body,
            headers={"Content-Type": "application/json"},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("v2-get-authorizers")
def v2_get_authorizers(
    api_id: str = typer.Option(..., "--api-id", help="API ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List authorizers for an HTTP API (V2)."""
    asyncio.run(_v2_get_authorizers(api_id, port))


async def _v2_get_authorizers(api_id: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "GET",
            f"/v2/apis/{api_id}/authorizers",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("v2-get-authorizer")
def v2_get_authorizer(
    api_id: str = typer.Option(..., "--api-id", help="API ID"),
    authorizer_id: str = typer.Option(..., "--authorizer-id", help="Authorizer ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get an authorizer for an HTTP API (V2)."""
    asyncio.run(_v2_get_authorizer(api_id, authorizer_id, port))


async def _v2_get_authorizer(api_id: str, authorizer_id: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "GET",
            f"/v2/apis/{api_id}/authorizers/{authorizer_id}",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("v2-delete-authorizer")
def v2_delete_authorizer(
    api_id: str = typer.Option(..., "--api-id", help="API ID"),
    authorizer_id: str = typer.Option(..., "--authorizer-id", help="Authorizer ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete an authorizer for an HTTP API (V2)."""
    asyncio.run(_v2_delete_authorizer(api_id, authorizer_id, port))


async def _v2_delete_authorizer(api_id: str, authorizer_id: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "DELETE",
            f"/v2/apis/{api_id}/authorizers/{authorizer_id}",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json() if resp.content else {})
