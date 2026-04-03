"""LwsSession — main entry point for the lws testing SDK."""

from __future__ import annotations

import asyncio
import os
import shutil
import tempfile
import threading
from collections.abc import Generator
from contextlib import contextmanager
from pathlib import Path
from typing import Any

from lws_testing._session_helpers import (
    SERVICE_ENV_VARS as _SERVICE_ENV_VARS,
)
from lws_testing._session_helpers import (
    TEST_CREDENTIALS as _TEST_CREDENTIALS,
)
from lws_testing._session_helpers import (
    parse_typed_resources as _parse_typed_resources,
)
from lws_testing._spec import (
    DynamoTable,
    S3Bucket,
    Secret,
    SnsTopic,
    SqsQueue,
    SsmParameter,
    StateMachine,
)

ResourceSpec = DynamoTable | SqsQueue | S3Bucket | SnsTopic | SsmParameter | Secret | StateMachine


class LwsSession:
    """In-process LWS session for testing.

    Starts all LWS service providers in background threads within the test
    process, patches boto3 clients, and provides helpers for seeding state,
    configuring fakes, capturing logs, and asserting side effects.

    Use as a context manager::

        with LwsSession.from_cdk("../") as session:
            dynamo = session.client("dynamodb")
            dynamo.put_item(TableName="Orders", Item={...})

    Or construct with typed resource specs::

        with LwsSession(
            DynamoTable("Orders", hash_key="id"),
            SqsQueue("OrderQueue"),
        ) as session:
            ...

    Or with the legacy dict-based API (still supported)::

        with LwsSession(
            tables=[{"name": "Orders", "partition_key": "id"}],
            queues=["OrderQueue"],
        ) as session:
            ...
    """

    def __init__(
        self,
        *resources: ResourceSpec,
        tables: list[dict[str, Any]] | None = None,
        queues: list[str] | None = None,
        buckets: list[str] | None = None,
        topics: list[str] | None = None,
        state_machines: list[dict[str, Any]] | None = None,
        secrets: list[str] | None = None,
        parameters: list[str] | None = None,
    ) -> None:
        typed = _parse_typed_resources(resources)
        self._spec: dict[str, Any] = {
            "tables": (tables or []) + typed["tables"],
            "queues": (queues or []) + typed["queues"],
            "buckets": (buckets or []) + typed["buckets"],
            "topics": (topics or []) + typed["topics"],
            "state_machines": (state_machines or []) + typed["state_machines"],
            "secrets": (secrets or []) + typed["secrets"],
            "parameters": (parameters or []) + typed["parameters"],
        }
        self._ports: dict[str, int] = {}
        self._mgmt_port: int = 0
        self._servers: list[Any] = []
        self._providers: dict[str, Any] = {}
        self._loop: asyncio.AbstractEventLoop | None = None
        self._thread: threading.Thread | None = None
        self._data_dir: Path | None = None
        self._log_handler: Any = None
        self._saved_env: dict[str, str | None] = {}

    # ── Constructors ──────────────────────────────────────────────────────────

    @classmethod
    def from_cdk(cls, project_dir: str = ".") -> LwsSession:
        """Create a session by discovering resources from a CDK project.

        Reads the synthesised cloud assembly in ``{project_dir}/cdk.out/``.
        Run ``npx cdk synth`` before starting the session if ``cdk.out/``
        is not already present.

        Args:
            project_dir: Path to the CDK project root (default: current directory).
        """
        from lws_testing._discovery.cdk import discover

        spec = discover(Path(project_dir))
        return cls(**spec)

    @classmethod
    def from_hcl(cls, project_dir: str = ".") -> LwsSession:
        """Create a session by discovering resources from an HCL project.

        Reads ``.tf`` files in ``project_dir`` to discover tables, queues,
        buckets and other resources.

        Args:
            project_dir: Path to the directory containing ``.tf`` files.
        """
        from lws_testing._discovery.hcl import discover

        spec = discover(Path(project_dir))
        return cls(**spec)

    # ── Context manager ───────────────────────────────────────────────────────

    def __enter__(self) -> LwsSession:
        self._start()
        return self

    def __exit__(self, *args: object) -> None:
        self._stop()

    # ── Lifecycle ─────────────────────────────────────────────────────────────

    def _start(self) -> None:
        """Start all service providers in background threads."""
        self._data_dir = Path(tempfile.mkdtemp(prefix="lws_testing_"))
        self._loop = asyncio.new_event_loop()
        ready = threading.Event()
        error_holder: list[Exception] = []

        def run_loop() -> None:
            asyncio.set_event_loop(self._loop)
            try:
                self._loop.run_until_complete(self._async_start(ready))
                self._loop.run_forever()
            except Exception as exc:  # pylint: disable=broad-except
                error_holder.append(exc)
                ready.set()

        self._thread = threading.Thread(target=run_loop, daemon=True, name="lws-testing")
        self._thread.start()
        ready.wait(timeout=30)

        if error_holder:
            exc = error_holder[0]
            raise RuntimeError(f"LwsSession failed to start: {exc}") from exc

        self._patch_env()

    async def _async_start(self, ready: threading.Event) -> None:
        """Create providers, build apps, start servers."""
        from lws_testing._transport.inprocess import start_services

        (
            self._log_handler,
            self._ports,
            self._mgmt_port,
            self._servers,
            self._providers,
        ) = await start_services(self._spec, self._data_dir)
        ready.set()

    def _stop(self) -> None:
        """Stop all servers and clean up temporary state."""
        self._restore_env()

        if self._loop and self._loop.is_running():
            future = asyncio.run_coroutine_threadsafe(self._async_stop(), self._loop)
            future.result(timeout=10)
            self._loop.call_soon_threadsafe(self._loop.stop)

        if self._thread:
            self._thread.join(timeout=5)

        if self._data_dir and self._data_dir.exists():
            shutil.rmtree(self._data_dir, ignore_errors=True)

    async def _async_stop(self) -> None:
        """Gracefully shut down all servers."""
        from lws_testing._transport.inprocess import stop_services

        await stop_services(self._servers, self._providers)

    # ── Environment patching ──────────────────────────────────────────────────

    def _patch_env(self) -> None:
        """Set AWS SDK endpoint env vars so any boto3 client hits local LWS.

        This is the drop-in mechanism: production code that creates boto3
        clients the normal way (``boto3.client("dynamodb")``) is automatically
        redirected to the local services without any code changes.
        """
        for service, env_var in _SERVICE_ENV_VARS.items():
            port = self._ports.get(service)
            if port:
                self._saved_env[env_var] = os.environ.get(env_var)
                os.environ[env_var] = f"http://127.0.0.1:{port}"
        for key, val in _TEST_CREDENTIALS.items():
            self._saved_env[key] = os.environ.get(key)
            os.environ[key] = val

    def _restore_env(self) -> None:
        """Restore all env vars that were overridden by :meth:`_patch_env`."""
        for key, saved in self._saved_env.items():
            if saved is None:
                os.environ.pop(key, None)
            else:
                os.environ[key] = saved
        self._saved_env = {}

    # ── boto3 client factory ──────────────────────────────────────────────────

    def client(self, service: str, config: Any = None) -> Any:
        """Return a pre-configured client for the given service.

        For standard AWS services (e.g. ``"dynamodb"``, ``"sqs"``) this returns a
        boto3 client pointed at the local service endpoint.  For ``"fake"`` and
        ``"aws_fake"`` it returns the respective management API client.

        Args:
            service: Service name.  AWS services use their boto3 name; use
                ``"fake"`` for the fake server management client and ``"aws_fake"``
                for the AWS fake interceptor client.
            config: Optional botocore Config object (AWS services only).
        """
        if service == "fake":
            from lws_testing._management.fake import (  # pylint: disable=import-outside-toplevel
                FakeServerClient,
            )

            return FakeServerClient(self._mgmt_port)
        if service == "aws_fake":
            from lws_testing._management.aws_fake import (  # pylint: disable=import-outside-toplevel
                AwsFakeClient,
            )

            return AwsFakeClient(self._mgmt_port)

        import boto3  # pylint: disable=import-outside-toplevel

        port = self._ports.get(service)
        if port is None:
            raise ValueError(
                f"Service {service!r} is not available in this session. "
                f"Available: {sorted(self._ports)}"
            )
        import re  # pylint: disable=import-outside-toplevel

        boto_client = boto3.client(
            service,
            endpoint_url=f"http://127.0.0.1:{port}",
            region_name="us-east-1",
            aws_access_key_id="test",
            aws_secret_access_key="test",
            config=config,
        )
        if service == "stepfunctions":
            # boto3/botocore prepends "sync-" to the hostname for StartSyncExecution
            # (e.g. http://127.0.0.1:PORT → http://sync-127.0.0.1:PORT).
            # Strip that prefix so requests reach the local service.
            def _fix_sync_url(request, **_kwargs):  # type: ignore[no-untyped-def]
                request.url = re.sub(r"(https?://)sync-", r"\1", request.url)

            boto_client.meta.events.register(
                "before-send.stepfunctions.StartSyncExecution", _fix_sync_url
            )
        return boto_client

    def reset(self) -> None:
        """Clear all service state. Call between tests to ensure isolation."""
        import httpx  # pylint: disable=import-outside-toplevel

        httpx.post(f"http://127.0.0.1:{self._mgmt_port}/_ldk/reset")

    def inject_state(self, service: str, resource_type: str, resource_id: str, state: str) -> None:
        """Inject a resource state via PUT /_ldk/state/{service}/{resource_type}/{resource_id}."""
        import pytest  # pylint: disable=import-outside-toplevel

        from lws_testing._management.state import (  # pylint: disable=import-outside-toplevel  # noqa: E501
            InjectStateNotTracked,
        )
        from lws_testing._management.state import (
            inject_state as _inject_state,
        )

        try:
            _inject_state(self._mgmt_port, service, resource_type, resource_id, state)
        except InjectStateNotTracked:
            pytest.skip(
                f"inject_state: {service}/{resource_type}/{resource_id} is not tracked — skipping"
            )

    def clear_injected_state(self, service: str, resource_type: str, resource_id: str) -> None:
        """Clear an injected resource state via DELETE /_ldk/state."""
        from lws_testing._management.state import (
            clear_injected_state as _clear,  # pylint: disable=import-outside-toplevel
        )

        _clear(self._mgmt_port, service, resource_type, resource_id)

    def get_injected_state(self, service: str, resource_type: str, resource_id: str) -> str | None:
        """Return the injected state for a resource, or None if not set."""
        from lws_testing._management.state import (
            get_injected_state as _get,  # pylint: disable=import-outside-toplevel
        )

        return _get(self._mgmt_port, service, resource_type, resource_id)

    def dynamodb(self, table_name: str) -> Any:
        """Return a DynamoDB table helper for seeding and asserting."""
        from lws_testing._resources.dynamodb import DynamoDBHelper

        return DynamoDBHelper(table_name, self.client("dynamodb"))

    def sqs(self, queue_name: str) -> Any:
        """Return an SQS queue helper for seeding and asserting."""
        from lws_testing._resources.sqs import SQSHelper

        return SQSHelper(queue_name, self.client("sqs"), self._ports["sqs"])

    def s3(self, bucket_name: str) -> Any:
        """Return an S3 bucket helper for seeding and asserting."""
        from lws_testing._resources.s3 import S3Helper

        return S3Helper(bucket_name, self.client("s3"))

    @property
    def management_url(self) -> str:
        """Return the base URL for the LWS management API (``/_ldk/…``)."""
        return f"http://127.0.0.1:{self._mgmt_port}"

    def port_for(self, service: str) -> int:
        """Return the local port number for the given service.

        Args:
            service: AWS service name (e.g. ``"dynamodb"``, ``"sqs"``).
        """
        port = self._ports.get(service)
        if port is None:
            raise ValueError(
                f"Service {service!r} is not available in this session. "
                f"Available: {sorted(self._ports)}"
            )
        return port

    def queue_url(self, queue_name: str) -> str:
        """Return the local SQS URL for *queue_name*.

        Use this to set the queue URL env var that production code reads::

            os.environ["ORDER_QUEUE_URL"] = session.queue_url("OrderQueue")
        """
        return f"http://127.0.0.1:{self._ports['sqs']}/000000000000/{queue_name}"

    def fake(self, service: str) -> Any:
        """Return a fluent fake builder for the given service."""
        from lws_testing._builders.fake import FakeBuilder

        return FakeBuilder(service, self._mgmt_port)

    def chaos(self, service: str) -> Any:
        """Return a fluent chaos builder for the given service."""
        from lws_testing._builders.chaos import ChaosBuilder

        return ChaosBuilder(service, self._mgmt_port)

    def set_chaos(self, service: str, error_rate: float = 1.0, latency_ms: int = 0) -> None:
        """Enable chaos for *service* (PUT /_ldk/chaos/{service})."""
        from lws_testing._management.chaos import (  # pylint: disable=import-outside-toplevel
            set_chaos as _set_chaos,
        )

        _set_chaos(self._mgmt_port, service, error_rate, latency_ms)

    def reset_chaos(self, service: str) -> None:
        """Disable and reset chaos for *service* (DELETE /_ldk/chaos/{service})."""
        from lws_testing._management.chaos import (  # pylint: disable=import-outside-toplevel
            reset_chaos as _reset_chaos,
        )

        _reset_chaos(self._mgmt_port, service)

    def get_chaos_status(self, service: str) -> dict[str, Any]:
        """Return the current chaos configuration for *service* (GET /_ldk/chaos/{service})."""
        from lws_testing._management.chaos import (  # pylint: disable=import-outside-toplevel
            get_chaos_status as _get_chaos_status,
        )

        return _get_chaos_status(self._mgmt_port, service)

    def lifecycle(self, service: str) -> Any:
        """Return a fluent lifecycle builder for the given service."""
        from lws_testing._builders.lifecycle import LifecycleBuilder

        return LifecycleBuilder(service, self._mgmt_port)

    def capacity(self, service: str) -> Any:
        """Return a fluent capacity builder for the given service."""
        from lws_testing._builders.capacity import CapacityBuilder

        return CapacityBuilder(service, self._mgmt_port)

    @property
    def iam(self) -> Any:
        """Return the IAM authorization builder."""
        from lws_testing._builders.iam import IamBuilder

        return IamBuilder(self._mgmt_port)

    @contextmanager
    def capture_logs(self) -> Generator[Any, None, None]:
        """Capture all log entries emitted during the block.

        Usage::

            with session.capture_logs() as logs:
                my_service.create_order(...)

            logs.assert_called("dynamodb", "PutItem")
            logs.assert_no_errors()
        """
        from lws_testing._logs import LogCapture

        capture = LogCapture(self._log_handler)
        capture.start()
        try:
            yield capture
        finally:
            capture.stop()

    def recent_logs(self) -> list[dict[str, Any]]:
        """Return all buffered log entries from the current session."""
        if self._log_handler is None:
            return []
        return self._log_handler.backlog()

    # ── Lambda helpers ────────────────────────────────────────────────────────

    def get_lambda_invocations(self, function_name: str) -> list[dict[str, Any]]:
        """Return the list of invocation records for a Lambda function.

        Calls ``GET /lws/lambda/invocations/{function_name}`` on the Lambda
        management API and returns the ``Invocations`` list.

        Args:
            function_name: The Lambda function name to query.
        """
        import httpx  # pylint: disable=import-outside-toplevel

        port = self._ports.get("lambda")
        if port is None:
            return []
        resp = httpx.get(f"http://127.0.0.1:{port}/lws/lambda/invocations/{function_name}")
        if resp.status_code != 200:
            return []
        return resp.json().get("Invocations", [])
