"""ICompute interface for Lambda-like function invocation."""

import time
from abc import abstractmethod
from dataclasses import dataclass, field
from pathlib import Path

from lws.interfaces.provider import Provider


@dataclass
class LambdaContext:
    """Context object passed to Lambda function invocations.

    Mirrors the AWS Lambda context object, providing metadata about
    the function invocation and a method to query remaining execution time.
    """

    function_name: str
    memory_limit_in_mb: int
    timeout_seconds: int
    aws_request_id: str
    invoked_function_arn: str
    _start_time: float = field(default_factory=time.monotonic)

    def get_remaining_time_in_millis(self) -> int:
        """Return the number of milliseconds remaining before the function times out."""
        elapsed = time.monotonic() - self._start_time
        remaining = self.timeout_seconds - elapsed
        return max(0, int(remaining * 1000))


@dataclass
class InvocationResult:
    """Result of a Lambda function invocation."""

    payload: dict | None
    error: str | None
    duration_ms: float
    request_id: str


@dataclass
class ComputeConfig:
    """Configuration for a compute (Lambda) function."""

    function_name: str
    handler: str
    runtime: str
    code_path: Path
    timeout: int = 3
    memory_size: int = 128
    environment: dict[str, str] = field(default_factory=dict)


class ICompute(Provider):
    """Abstract interface for compute providers (Lambda-like).

    Implementations handle loading, configuring, and invoking
    serverless function handlers.
    """

    @abstractmethod
    async def invoke(self, event: dict, context: LambdaContext) -> InvocationResult:
        """Invoke a function with the given event and context."""
        ...
