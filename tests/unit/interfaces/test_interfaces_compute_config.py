"""Tests for LDK interface definitions (P0-07 through P0-10)."""

from lws.interfaces import (
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

        # Arrange
        expected_timeout = 3
        expected_memory_size = 128

        # Act
        cfg = ComputeConfig(
            function_name="fn",
            handler="index.handler",
            runtime="python3.11",
            code_path=Path("/tmp/code"),
        )

        # Assert
        assert cfg.timeout == expected_timeout
        assert cfg.memory_size == expected_memory_size
        assert cfg.environment == {}

    def test_custom_values(self) -> None:
        from pathlib import Path

        # Arrange
        expected_timeout = 30
        expected_memory_size = 512
        expected_environment = {"FOO": "bar"}

        # Act
        cfg = ComputeConfig(
            function_name="fn",
            handler="index.handler",
            runtime="python3.11",
            code_path=Path("/tmp/code"),
            timeout=expected_timeout,
            memory_size=expected_memory_size,
            environment=expected_environment,
        )

        # Assert
        assert cfg.timeout == expected_timeout
        assert cfg.memory_size == expected_memory_size
        assert cfg.environment == expected_environment
