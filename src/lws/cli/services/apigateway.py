"""``lws apigateway`` sub-commands."""

from __future__ import annotations

import asyncio

import typer

from lws.cli.services.client import LwsClient, exit_with_error, output_json

app = typer.Typer(help="API Gateway commands")

_SERVICE = "apigateway"


def _client(port: int) -> LwsClient:
    return LwsClient(port=port)


@app.command("test-invoke-method")
def test_invoke_method(
    rest_api_name: str = typer.Option("default", "--rest-api-name", help="REST API name"),
    resource: str = typer.Option(..., "--resource", help="Resource path (e.g. /orders)"),
    http_method: str = typer.Option(..., "--http-method", help="HTTP method (GET, POST, etc.)"),
    body: str = typer.Option(None, "--body", help="Request body (JSON string)"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Invoke an API Gateway route."""
    asyncio.run(_test_invoke_method(rest_api_name, resource, http_method, body, port))


async def _test_invoke_method(
    rest_api_name: str,
    resource: str,
    http_method: str,
    body: str | None,
    port: int,
) -> None:
    client = _client(port)
    try:
        api_port = await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))

    import httpx

    request_body = body.encode() if body else None
    headers: dict[str, str] = {}
    if body:
        headers["Content-Type"] = "application/json"

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

    result = {
        "status": resp.status_code,
        "headers": dict(resp.headers),
        "body": resp_body,
    }
    output_json(result)
