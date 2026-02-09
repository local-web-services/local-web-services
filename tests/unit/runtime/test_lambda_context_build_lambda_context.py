"""Tests for ldk.runtime.lambda_context (P1-03)."""

from __future__ import annotations

from pathlib import Path

from lws.interfaces import ComputeConfig
from lws.runtime.lambda_context import build_lambda_context

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _make_config(**overrides) -> ComputeConfig:
    defaults = dict(
        function_name="my-func",
        handler="handler.main",
        runtime="python3.11",
        code_path=Path("/tmp/code"),
        timeout=30,
        memory_size=256,
        environment={},
    )
    defaults.update(overrides)
    return ComputeConfig(**defaults)


# ---------------------------------------------------------------------------
# build_lambda_context tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# get_remaining_time_in_millis tests
# ---------------------------------------------------------------------------


class TestBuildLambdaContext:
    """Verify that build_lambda_context creates a valid LambdaContext."""

    def test_function_name_is_set(self) -> None:
        ctx = build_lambda_context(_make_config(function_name="TestFunc"))
        assert ctx.function_name == "TestFunc"

    def test_memory_limit_matches_config(self) -> None:
        ctx = build_lambda_context(_make_config(memory_size=512))
        assert ctx.memory_limit_in_mb == 512

    def test_timeout_matches_config(self) -> None:
        ctx = build_lambda_context(_make_config(timeout=60))
        assert ctx.timeout_seconds == 60

    def test_aws_request_id_is_uuid(self) -> None:
        ctx = build_lambda_context(_make_config())
        # UUIDs have the format xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
        parts = ctx.aws_request_id.split("-")
        assert len(parts) == 5
        assert len(parts[0]) == 8

    def test_each_call_generates_unique_request_id(self) -> None:
        config = _make_config()
        ctx1 = build_lambda_context(config)
        ctx2 = build_lambda_context(config)
        assert ctx1.aws_request_id != ctx2.aws_request_id

    def test_invoked_function_arn_format(self) -> None:
        ctx = build_lambda_context(_make_config(function_name="MyFunc"))
        assert ctx.invoked_function_arn == ("arn:aws:lambda:us-east-1:123456789012:function:MyFunc")
