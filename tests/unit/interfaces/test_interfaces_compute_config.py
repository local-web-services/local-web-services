"""Tests for LDK interface definitions (P0-07 through P0-10)."""

from ldk.interfaces import (
    ComputeConfig,
)

# ---------------------------------------------------------------------------
# P0-07: Provider lifecycle
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P0-08: ICompute
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P0-09: IKeyValueStore
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P0-10: Remaining provider interfaces
# ---------------------------------------------------------------------------


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
