"""Factory for building LambdaContext instances from ComputeConfig."""

from __future__ import annotations

import uuid

from ldk.interfaces.compute import ComputeConfig, LambdaContext


def build_lambda_context(config: ComputeConfig) -> LambdaContext:
    """Create a new :class:`LambdaContext` from a :class:`ComputeConfig`.

    Generates a fresh UUID for ``aws_request_id`` and constructs the
    ``invoked_function_arn`` from the function name.  The context's
    ``_start_time`` is set automatically by the dataclass default so that
    :meth:`get_remaining_time_in_millis` provides a real countdown.

    Args:
        config: The compute configuration for the Lambda function.

    Returns:
        A fully-populated :class:`LambdaContext` ready for invocation.
    """
    request_id = str(uuid.uuid4())
    function_arn = f"arn:aws:lambda:us-east-1:123456789012:function:{config.function_name}"

    return LambdaContext(
        function_name=config.function_name,
        memory_limit_in_mb=config.memory_size,
        timeout_seconds=config.timeout,
        aws_request_id=request_id,
        invoked_function_arn=function_arn,
    )
