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
        # Arrange
        expected_name = "TestFunc"

        # Act
        ctx = build_lambda_context(_make_config(function_name=expected_name))

        # Assert
        assert ctx.function_name == expected_name

    def test_memory_limit_matches_config(self) -> None:
        # Arrange
        expected_memory = 512

        # Act
        ctx = build_lambda_context(_make_config(memory_size=expected_memory))

        # Assert
        assert ctx.memory_limit_in_mb == expected_memory

    def test_timeout_matches_config(self) -> None:
        # Arrange
        expected_timeout = 60

        # Act
        ctx = build_lambda_context(_make_config(timeout=expected_timeout))

        # Assert
        assert ctx.timeout_seconds == expected_timeout

    def test_aws_request_id_is_uuid(self) -> None:
        # Arrange
        expected_part_count = 5
        expected_first_part_length = 8

        # Act
        ctx = build_lambda_context(_make_config())

        # Assert -- UUIDs have the format xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
        parts = ctx.aws_request_id.split("-")
        assert len(parts) == expected_part_count
        assert len(parts[0]) == expected_first_part_length

    def test_each_call_generates_unique_request_id(self) -> None:
        # Arrange
        config = _make_config()

        # Act
        ctx1 = build_lambda_context(config)
        ctx2 = build_lambda_context(config)

        # Assert
        assert ctx1.aws_request_id != ctx2.aws_request_id

    def test_invoked_function_arn_format(self) -> None:
        # Arrange
        expected_arn = "arn:aws:lambda:us-east-1:123456789012:function:MyFunc"

        # Act
        ctx = build_lambda_context(_make_config(function_name="MyFunc"))

        # Assert
        assert ctx.invoked_function_arn == expected_arn
