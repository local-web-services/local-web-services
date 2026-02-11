"""Shared Lambda context construction helpers."""

from __future__ import annotations

import uuid

from lws.interfaces import LambdaContext

_REGION = "us-east-1"
_ACCOUNT_ID = "000000000000"


def build_default_lambda_context(function_name: str) -> LambdaContext:
    """Build a LambdaContext with default settings for local invocations."""
    request_id = str(uuid.uuid4())
    return LambdaContext(
        function_name=function_name,
        memory_limit_in_mb=128,
        timeout_seconds=30,
        aws_request_id=request_id,
        invoked_function_arn=f"arn:aws:lambda:{_REGION}:{_ACCOUNT_ID}:function:{function_name}",
    )
