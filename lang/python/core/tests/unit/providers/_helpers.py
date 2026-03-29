from __future__ import annotations

import asyncio
from typing import Any

from lws.providers.stepfunctions.engine import StatesTaskFailed


class FakeRequest:
    """Minimal Starlette-compatible request stub for unit tests."""

    def __init__(self, body: bytes, content_type: str = "application/x-www-form-urlencoded"):
        self._body = body
        self.headers = {"content-type": content_type}

    async def body(self) -> bytes:
        return self._body


class FakeLambdaHandler:
    """Collects stream events for assertions."""

    def __init__(self) -> None:
        self.invocations: list[dict[str, Any]] = []
        self._event = asyncio.Event()

    async def __call__(self, event: dict[str, Any]) -> None:
        self.invocations.append(event)
        self._event.set()

    async def wait_for_invocation(self, timeout: float = 2.0) -> None:
        """Wait until at least one invocation occurs."""
        await asyncio.wait_for(self._event.wait(), timeout=timeout)

    def reset(self) -> None:
        self.invocations.clear()
        self._event.clear()


class FakeCompute:
    """Fake compute invoker for testing."""

    def __init__(self, results: dict[str, Any] | None = None) -> None:
        self._results = results or {}
        self._call_count: dict[str, int] = {}
        self._error_until: dict[str, int] = {}

    async def invoke_function(self, resource_arn: str, payload: Any) -> Any:
        count = self._call_count.get(resource_arn, 0) + 1
        self._call_count[resource_arn] = count

        error_threshold = self._error_until.get(resource_arn, 0)
        if count <= error_threshold:
            raise StatesTaskFailed("States.TaskFailed", f"Error on attempt {count}")

        if resource_arn in self._results:
            result = self._results[resource_arn]
            if callable(result):
                return result(payload)
            return result
        return payload

    def set_error_until(self, resource_arn: str, attempts: int) -> None:
        """Make the function fail for the first N attempts."""
        self._error_until[resource_arn] = attempts


class SlowCompute:
    """Compute that takes a long time (for timeout tests)."""

    async def invoke_function(self, resource_arn: str, payload: Any) -> Any:
        await asyncio.sleep(10)
        return payload


# ---------------------------------------------------------------------------
# Fake service providers for ServiceTaskBridge tests
# ---------------------------------------------------------------------------


class FakeDynamoDB:
    """Fake DynamoDB provider for bridge tests."""

    def __init__(self, tables: set[str] | None = None) -> None:
        self.put_calls: list[tuple[str, dict]] = []
        self.get_responses: dict[str, dict | None] = {}
        self._tables: set[str] = tables if tables is not None else {"_default_allow_all"}
        self._allow_all: bool = tables is None

    async def describe_table(self, table_name: str) -> dict:
        if not self._allow_all and table_name not in self._tables:
            raise KeyError(f"Table not found: {table_name}")
        return {"TableName": table_name, "TableStatus": "ACTIVE"}

    async def put_item(self, table_name: str, item: dict) -> None:
        self.put_calls.append((table_name, item))

    async def get_item(self, table_name: str, key: dict) -> dict | None:
        return self.get_responses.get(table_name)


class FakeSqs:
    """Fake SQS provider for bridge tests."""

    def __init__(self, message_id: str = "msg-001", queues: set[str] | None = None) -> None:
        self._message_id = message_id
        self.send_calls: list[tuple[str, str]] = []
        self._queues: set[str] | None = queues

    def get_queue(self, queue_name: str) -> object | None:
        if self._queues is None:
            return object()  # sentinel: queue exists
        if queue_name in self._queues:
            return object()
        return None

    async def send_message(self, queue_name: str, message_body: str) -> str:
        self.send_calls.append((queue_name, message_body))
        return self._message_id


class FakeSns:
    """Fake SNS provider for bridge tests."""

    def __init__(self, message_id: str = "sns-msg-001", topics: set[str] | None = None) -> None:
        self._message_id = message_id
        self.publish_calls: list[tuple[str, str]] = []
        self._topics: set[str] | None = topics

    def get_topic(self, topic_name: str) -> object:
        if self._topics is None:
            return object()  # sentinel: topic exists
        if topic_name in self._topics:
            return object()
        raise KeyError(f"Topic not found: {topic_name}")

    async def publish(self, topic_name: str, message: str) -> str:
        self.publish_calls.append((topic_name, message))
        return self._message_id


class FakeS3:
    """Fake S3 provider for bridge tests."""

    def __init__(self, buckets: set[str] | None = None) -> None:
        self._store: dict[str, bytes] = {}
        self._buckets: set[str] | None = buckets

    async def head_bucket(self, bucket_name: str) -> dict:
        if self._buckets is None:
            return {"BucketName": bucket_name}
        if bucket_name in self._buckets:
            return {"BucketName": bucket_name}
        raise KeyError(f"Bucket not found: {bucket_name}")

    async def get_object(self, bucket: str, key: str) -> bytes | None:
        return self._store.get(f"{bucket}/{key}")

    async def put_object(self, bucket: str, key: str, body: bytes) -> None:
        self._store[f"{bucket}/{key}"] = body


class FakeEventBridge:
    """Fake EventBridge provider for bridge tests."""

    def __init__(self) -> None:
        self.put_calls: list[list[dict]] = []

    async def put_events(self, entries: list[dict]) -> list[dict]:
        self.put_calls.append(entries)
        return [{"EventId": f"evt-{i}"} for i, _ in enumerate(entries)]


class FakeSsmAdapter:
    """Fake SSM adapter for bridge tests."""

    def get_parameter(self, name: str) -> dict:
        return {"Parameter": {"Name": name, "Value": "param-value"}}


class FakeSecretsManagerAdapter:
    """Fake SecretsManager adapter for bridge tests."""

    def get_secret_value(self, secret_id: str) -> dict:
        return {"Name": secret_id, "SecretString": "secret-value"}


class FakeServiceBridge:
    """Records which ARNs it handled, for composite invoker tests."""

    def __init__(self, handled_arns: set[str] | None = None) -> None:
        self._handled = handled_arns or set()
        self.invoked_arns: list[str] = []

    def handles(self, resource_arn: str) -> bool:
        return resource_arn in self._handled

    async def invoke(self, resource_arn: str, payload: Any) -> Any:
        self.invoked_arns.append(resource_arn)
        return {"service": resource_arn}


class FakeExhaustedCapacity:
    """Capacity object that is always exhausted (slots == 0)."""

    is_exhausted = True


class FakeUnlimitedCapacity:
    """Capacity object that is never exhausted (slots == None)."""

    is_exhausted = False


class FakeLambdaBridge:
    """Records which ARNs it handled, for composite invoker tests."""

    def __init__(self) -> None:
        self.invoked_arns: list[str] = []

    async def invoke_function(self, resource_arn: str, payload: Any) -> Any:
        self.invoked_arns.append(resource_arn)
        return {"lambda": resource_arn}


class FakeRotationCompute:
    """Stub ICompute that records invocations for rotation tests."""

    def __init__(self, *, should_fail: bool = False) -> None:
        self.invocations: list[dict] = []
        self._should_fail = should_fail

    async def invoke(self, event: dict, _context) -> object:
        self.invocations.append(event)

        class _Result:
            error = None
            payload = {}

        class _FailResult:
            error = "lambda error"
            payload = None

        return _FailResult() if self._should_fail else _Result()


class FakeRotationRegistry:
    """Stub LambdaRegistry that returns a fixed compute for rotation tests."""

    def __init__(self, compute: FakeRotationCompute) -> None:
        self._compute = compute

    def get_compute(self, _function_name: str) -> FakeRotationCompute:
        return self._compute
