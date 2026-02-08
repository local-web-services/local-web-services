from __future__ import annotations

import asyncio
from typing import Any

from ldk.providers.stepfunctions.engine import StatesTaskFailed


class MockLambdaHandler:
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


class MockCompute:
    """Mock compute invoker for testing."""

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
