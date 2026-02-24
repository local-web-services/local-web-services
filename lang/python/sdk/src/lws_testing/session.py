"""LwsSession — main entry point for the lws testing SDK."""

from __future__ import annotations

import asyncio
import os
import shutil
import socket
import tempfile
import threading
from collections.abc import Generator
from contextlib import contextmanager
from pathlib import Path
from typing import Any

# Maps boto3 service name → AWS SDK endpoint URL env var.
# Setting these redirects *any* boto3 client created in the process to the
# local LWS service — no production-code changes required.
_SERVICE_ENV_VARS: dict[str, str] = {
    "dynamodb": "AWS_ENDPOINT_URL_DYNAMODB",
    "sqs": "AWS_ENDPOINT_URL_SQS",
    "s3": "AWS_ENDPOINT_URL_S3",
    "sns": "AWS_ENDPOINT_URL_SNS",
    "stepfunctions": "AWS_ENDPOINT_URL_STEPFUNCTIONS",
    "ssm": "AWS_ENDPOINT_URL_SSM",
    "secretsmanager": "AWS_ENDPOINT_URL_SECRETSMANAGER",
}

# Credential / region overrides so boto3 never tries to contact IAM or STS.
_TEST_CREDENTIALS: dict[str, str] = {
    "AWS_ACCESS_KEY_ID": "test",
    "AWS_SECRET_ACCESS_KEY": "test",
    "AWS_DEFAULT_REGION": "us-east-1",
}


def _free_port() -> int:
    """Return a free ephemeral TCP port on localhost."""
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind(("127.0.0.1", 0))
        return s.getsockname()[1]


class LwsSession:
    """In-process LWS session for testing.

    Starts all LWS service providers in background threads within the test
    process, patches boto3 clients, and provides helpers for seeding state,
    configuring mocks, capturing logs, and asserting side effects.

    Use as a context manager::

        with LwsSession.from_cdk("../") as session:
            dynamo = session.client("dynamodb")
            dynamo.put_item(TableName="Orders", Item={...})

    Or construct directly with explicit resources::

        with LwsSession(
            tables=[{"name": "Orders", "partition_key": "id"}],
            queues=["OrderQueue"],
            buckets=["ReceiptsBucket"],
        ) as session:
            ...
    """

    def __init__(
        self,
        *,
        tables: list[dict[str, Any]] | None = None,
        queues: list[str] | None = None,
        buckets: list[str] | None = None,
        topics: list[str] | None = None,
        state_machines: list[dict[str, Any]] | None = None,
        secrets: list[str] | None = None,
        parameters: list[str] | None = None,
    ) -> None:
        self._spec: dict[str, Any] = {
            "tables": tables or [],
            "queues": queues or [],
            "buckets": buckets or [],
            "topics": topics or [],
            "state_machines": state_machines or [],
            "secrets": secrets or [],
            "parameters": parameters or [],
        }
        self._ports: dict[str, int] = {}
        self._mgmt_port: int = 0
        self._servers: list[Any] = []
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

        self._log_handler, self._ports, self._mgmt_port, self._servers = await start_services(
            self._spec, self._data_dir
        )
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

        await stop_services(self._servers)

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

    def client(self, service: str) -> Any:
        """Return a pre-configured boto3 client pointing at the local service.

        Args:
            service: AWS service name (e.g. ``"dynamodb"``, ``"sqs"``, ``"s3"``).
        """
        import boto3  # pylint: disable=import-outside-toplevel

        port = self._ports.get(service)
        if port is None:
            raise ValueError(
                f"Service {service!r} is not available in this session. "
                f"Available: {sorted(self._ports)}"
            )
        return boto3.client(
            service,
            endpoint_url=f"http://127.0.0.1:{port}",
            region_name="us-east-1",
            aws_access_key_id="test",
            aws_secret_access_key="test",
        )

    # ── State management ──────────────────────────────────────────────────────

    def reset(self) -> None:
        """Clear all service state. Call between tests to ensure isolation."""
        self._reset_dynamodb()
        self._reset_sqs()
        self._reset_s3()

    def _reset_dynamodb(self) -> None:
        """Delete all items from every DynamoDB table in the spec."""
        if "dynamodb" not in self._ports:
            return
        client = self.client("dynamodb")
        for table_spec in self._spec.get("tables", []):
            table_name = table_spec["name"]
            key_names = [table_spec["partition_key"]]
            if "sort_key" in table_spec:
                key_names.append(table_spec["sort_key"])
            self._truncate_table(client, table_name, key_names)

    def _truncate_table(self, client: Any, table_name: str, key_names: list[str]) -> None:
        """Scan and batch-delete all items from a DynamoDB table."""
        projection = ", ".join(f"#k{i}" for i in range(len(key_names)))
        names = {f"#k{i}": name for i, name in enumerate(key_names)}
        last_key = None
        while True:
            kwargs: dict[str, Any] = {
                "TableName": table_name,
                "ProjectionExpression": projection,
                "ExpressionAttributeNames": names,
            }
            if last_key:
                kwargs["ExclusiveStartKey"] = last_key
            response = client.scan(**kwargs)
            items = response.get("Items", [])
            for item in items:
                key = {k: item[k] for k in key_names}
                client.delete_item(TableName=table_name, Key=key)
            last_key = response.get("LastEvaluatedKey")
            if not last_key:
                break

    def _reset_sqs(self) -> None:
        """Purge all SQS queues in the spec."""
        if "sqs" not in self._ports:
            return
        client = self.client("sqs")
        port = self._ports["sqs"]
        for queue_spec in self._spec.get("queues", []):
            queue_name = queue_spec if isinstance(queue_spec, str) else queue_spec["name"]
            queue_url = f"http://127.0.0.1:{port}/000000000000/{queue_name}"
            try:
                client.purge_queue(QueueUrl=queue_url)
            except Exception:  # pylint: disable=broad-except
                pass

    def _reset_s3(self) -> None:
        """Delete all objects from every S3 bucket in the spec."""
        if "s3" not in self._ports:
            return
        client = self.client("s3")
        for bucket_spec in self._spec.get("buckets", []):
            bucket_name = bucket_spec if isinstance(bucket_spec, str) else bucket_spec["name"]
            paginator = client.get_paginator("list_objects_v2")
            for page in paginator.paginate(Bucket=bucket_name):
                for obj in page.get("Contents", []):
                    client.delete_object(Bucket=bucket_name, Key=obj["Key"])

    # ── Resource helpers ──────────────────────────────────────────────────────

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

    def queue_url(self, queue_name: str) -> str:
        """Return the local SQS URL for *queue_name*.

        Use this to set the queue URL env var that production code reads::

            os.environ["ORDER_QUEUE_URL"] = session.queue_url("OrderQueue")
        """
        return f"http://127.0.0.1:{self._ports['sqs']}/000000000000/{queue_name}"

    # ── Mock / chaos / IAM builders ───────────────────────────────────────────

    def mock(self, service: str) -> Any:
        """Return a fluent mock builder for the given service."""
        from lws_testing._builders.mock import MockBuilder

        return MockBuilder(service, self._mgmt_port)

    def chaos(self, service: str) -> Any:
        """Return a fluent chaos builder for the given service."""
        from lws_testing._builders.chaos import ChaosBuilder

        return ChaosBuilder(service, self._mgmt_port)

    @property
    def iam(self) -> Any:
        """Return the IAM authorization builder."""
        from lws_testing._builders.iam import IamBuilder

        return IamBuilder(self._mgmt_port)

    # ── Log capture ───────────────────────────────────────────────────────────

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
