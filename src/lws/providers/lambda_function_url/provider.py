"""Lambda Function URL provider.

Exposes a Lambda function as an HTTP endpoint on its own port,
emulating AWS Lambda Function URLs locally.
"""

from __future__ import annotations

from typing import Any

from lws.interfaces import Provider
from lws.providers.lambda_function_url.routes import create_lambda_function_url_app
from lws.providers.mockserver.provider import start_uvicorn_server, stop_uvicorn_server


class LambdaFunctionUrlProvider(Provider):
    """Serves a Lambda function as an HTTP endpoint (Function URL)."""

    def __init__(
        self,
        function_name: str,
        compute: Any,
        port: int,
        cors_config: dict[str, Any] | None = None,
    ) -> None:
        self._function_name = function_name
        self._compute = compute
        self._port = port
        self._cors_config = cors_config
        self._server = None
        self._task = None

    @property
    def name(self) -> str:
        return f"function-url:{self._function_name}"

    @property
    def port(self) -> int:
        """Return the port this Function URL is served on."""
        return self._port

    @property
    def function_name(self) -> str:
        """Return the Lambda function name."""
        return self._function_name

    async def start(self) -> None:
        app = create_lambda_function_url_app(self._function_name, self._compute, self._cors_config)
        self._server, self._task = await start_uvicorn_server(app, self._port)

    async def stop(self) -> None:
        await stop_uvicorn_server(self._server, self._task)
        self._server = None
        self._task = None

    async def health_check(self) -> bool:
        return self._server is not None
