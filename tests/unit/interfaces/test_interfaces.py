"""Tests for LDK interface definitions (P0-07 through P0-10)."""

import time

import pytest

from ldk.interfaces import (
    ComputeConfig,
    GsiDefinition,
    ICompute,
    IEventBus,
    IKeyValueStore,
    InvocationResult,
    IObjectStore,
    IQueue,
    IStateMachine,
    KeyAttribute,
    KeySchema,
    LambdaContext,
    Provider,
    ProviderError,
    ProviderStartError,
    ProviderStatus,
    ProviderStopError,
    TableConfig,
)

# ---------------------------------------------------------------------------
# P0-07: Provider lifecycle
# ---------------------------------------------------------------------------


class TestProviderStatus:
    """ProviderStatus enum has all expected members."""

    def test_has_stopped(self) -> None:
        assert ProviderStatus.STOPPED.value == "stopped"

    def test_has_starting(self) -> None:
        assert ProviderStatus.STARTING.value == "starting"

    def test_has_running(self) -> None:
        assert ProviderStatus.RUNNING.value == "running"

    def test_has_error(self) -> None:
        assert ProviderStatus.ERROR.value == "error"

    def test_member_count(self) -> None:
        assert len(ProviderStatus) == 4


class TestProviderExceptions:
    """Provider exception hierarchy is correct."""

    def test_provider_error_is_exception(self) -> None:
        assert issubclass(ProviderError, Exception)

    def test_start_error_inherits_provider_error(self) -> None:
        assert issubclass(ProviderStartError, ProviderError)

    def test_stop_error_inherits_provider_error(self) -> None:
        assert issubclass(ProviderStopError, ProviderError)

    def test_raise_start_error(self) -> None:
        with pytest.raises(ProviderStartError):
            raise ProviderStartError("boom")

    def test_raise_stop_error(self) -> None:
        with pytest.raises(ProviderStopError):
            raise ProviderStopError("boom")


class TestProviderABC:
    """Provider ABC cannot be instantiated directly."""

    def test_cannot_instantiate(self) -> None:
        with pytest.raises(TypeError):
            Provider()  # type: ignore[abstract]


# ---------------------------------------------------------------------------
# P0-08: ICompute
# ---------------------------------------------------------------------------


class TestICompute:
    """ICompute ABC cannot be instantiated directly."""

    def test_cannot_instantiate(self) -> None:
        with pytest.raises(TypeError):
            ICompute()  # type: ignore[abstract]


class TestLambdaContext:
    """LambdaContext dataclass and remaining-time logic."""

    def _make_context(self, timeout: int = 30) -> LambdaContext:
        return LambdaContext(
            function_name="my-func",
            memory_limit_in_mb=128,
            timeout_seconds=timeout,
            aws_request_id="abc-123",
            invoked_function_arn="arn:aws:lambda:us-east-1:123456789012:function:my-func",
        )

    def test_fields_set(self) -> None:
        ctx = self._make_context()
        assert ctx.function_name == "my-func"
        assert ctx.memory_limit_in_mb == 128
        assert ctx.timeout_seconds == 30
        assert ctx.aws_request_id == "abc-123"
        assert ctx.invoked_function_arn.startswith("arn:aws:lambda")

    def test_remaining_time_starts_near_timeout(self) -> None:
        ctx = self._make_context(timeout=10)
        remaining = ctx.get_remaining_time_in_millis()
        # Should be close to 10000 ms (allow 500ms tolerance for test overhead)
        assert 9500 <= remaining <= 10000

    def test_remaining_time_decreases(self) -> None:
        ctx = self._make_context(timeout=10)
        first = ctx.get_remaining_time_in_millis()
        time.sleep(0.05)
        second = ctx.get_remaining_time_in_millis()
        assert second < first

    def test_remaining_time_never_negative(self) -> None:
        ctx = LambdaContext(
            function_name="f",
            memory_limit_in_mb=128,
            timeout_seconds=0,
            aws_request_id="x",
            invoked_function_arn="arn",
            _start_time=time.monotonic() - 100,
        )
        assert ctx.get_remaining_time_in_millis() == 0


class TestInvocationResult:
    """InvocationResult dataclass fields."""

    def test_success_result(self) -> None:
        result = InvocationResult(
            payload={"statusCode": 200},
            error=None,
            duration_ms=42.5,
            request_id="req-1",
        )
        assert result.payload == {"statusCode": 200}
        assert result.error is None
        assert result.duration_ms == 42.5
        assert result.request_id == "req-1"

    def test_error_result(self) -> None:
        result = InvocationResult(
            payload=None,
            error="RuntimeError: kaboom",
            duration_ms=1.0,
            request_id="req-2",
        )
        assert result.payload is None
        assert result.error == "RuntimeError: kaboom"


class TestComputeConfig:
    """ComputeConfig dataclass defaults."""

    def test_defaults(self) -> None:
        from pathlib import Path

        cfg = ComputeConfig(
            function_name="fn",
            handler="index.handler",
            runtime="python3.11",
            code_path=Path("/tmp/code"),
        )
        assert cfg.timeout == 3
        assert cfg.memory_size == 128
        assert cfg.environment == {}

    def test_custom_values(self) -> None:
        from pathlib import Path

        cfg = ComputeConfig(
            function_name="fn",
            handler="index.handler",
            runtime="python3.11",
            code_path=Path("/tmp/code"),
            timeout=30,
            memory_size=512,
            environment={"FOO": "bar"},
        )
        assert cfg.timeout == 30
        assert cfg.memory_size == 512
        assert cfg.environment == {"FOO": "bar"}


# ---------------------------------------------------------------------------
# P0-09: IKeyValueStore
# ---------------------------------------------------------------------------


class TestIKeyValueStore:
    """IKeyValueStore ABC cannot be instantiated directly."""

    def test_cannot_instantiate(self) -> None:
        with pytest.raises(TypeError):
            IKeyValueStore()  # type: ignore[abstract]


class TestKeyValueStoreDataclasses:
    """Key-value store supporting dataclasses."""

    def test_key_attribute(self) -> None:
        attr = KeyAttribute(name="pk", type="S")
        assert attr.name == "pk"
        assert attr.type == "S"

    def test_key_schema_partition_only(self) -> None:
        schema = KeySchema(partition_key=KeyAttribute(name="pk", type="S"))
        assert schema.sort_key is None

    def test_key_schema_with_sort(self) -> None:
        schema = KeySchema(
            partition_key=KeyAttribute(name="pk", type="S"),
            sort_key=KeyAttribute(name="sk", type="S"),
        )
        assert schema.sort_key is not None
        assert schema.sort_key.name == "sk"

    def test_gsi_definition_defaults(self) -> None:
        gsi = GsiDefinition(
            index_name="gsi1",
            key_schema=KeySchema(
                partition_key=KeyAttribute(name="gsi1pk", type="S"),
            ),
        )
        assert gsi.projection_type == "ALL"

    def test_table_config(self) -> None:
        cfg = TableConfig(
            table_name="my-table",
            key_schema=KeySchema(
                partition_key=KeyAttribute(name="pk", type="S"),
            ),
        )
        assert cfg.table_name == "my-table"
        assert cfg.gsi_definitions == []


# ---------------------------------------------------------------------------
# P0-10: Remaining provider interfaces
# ---------------------------------------------------------------------------


class TestIQueue:
    """IQueue ABC cannot be instantiated directly."""

    def test_cannot_instantiate(self) -> None:
        with pytest.raises(TypeError):
            IQueue()  # type: ignore[abstract]


class TestIObjectStore:
    """IObjectStore ABC cannot be instantiated directly."""

    def test_cannot_instantiate(self) -> None:
        with pytest.raises(TypeError):
            IObjectStore()  # type: ignore[abstract]


class TestIEventBus:
    """IEventBus ABC cannot be instantiated directly."""

    def test_cannot_instantiate(self) -> None:
        with pytest.raises(TypeError):
            IEventBus()  # type: ignore[abstract]


class TestIStateMachine:
    """IStateMachine ABC cannot be instantiated directly."""

    def test_cannot_instantiate(self) -> None:
        with pytest.raises(TypeError):
            IStateMachine()  # type: ignore[abstract]
