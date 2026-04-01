"""Unit tests: ResourceLifecycleConfig.modify_dwell_ms field and parse."""

from __future__ import annotations

from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, parse_lifecycle_config


class TestModifyDwellMs:
    """ResourceLifecycleConfig and parse_lifecycle_config support modify_dwell_ms."""

    def test_default_modify_dwell_ms_is_zero(self) -> None:
        # Arrange
        config = ResourceLifecycleConfig()
        expected_modify_dwell_ms = 0

        # Act
        actual_modify_dwell_ms = config.modify_dwell_ms

        # Assert
        assert actual_modify_dwell_ms == expected_modify_dwell_ms, (
            f"Expected default modify_dwell_ms {expected_modify_dwell_ms!r} "
            f"but got {actual_modify_dwell_ms!r}"
        )

    def test_parse_lifecycle_config_reads_modify_dwell_ms(self) -> None:
        # Arrange
        expected_modify_dwell_ms = 250
        raw = {"modify_dwell_ms": expected_modify_dwell_ms}

        # Act
        config = parse_lifecycle_config(raw)
        actual_modify_dwell_ms = config.modify_dwell_ms

        # Assert
        assert actual_modify_dwell_ms == expected_modify_dwell_ms, (
            f"Expected modify_dwell_ms {expected_modify_dwell_ms!r} from parsed config "
            f"but got {actual_modify_dwell_ms!r}"
        )

    def test_parse_lifecycle_config_defaults_modify_dwell_ms_to_zero(self) -> None:
        # Arrange
        raw: dict = {}
        expected_modify_dwell_ms = 0

        # Act
        config = parse_lifecycle_config(raw)
        actual_modify_dwell_ms = config.modify_dwell_ms

        # Assert
        assert actual_modify_dwell_ms == expected_modify_dwell_ms, (
            f"Expected default modify_dwell_ms {expected_modify_dwell_ms!r} "
            f"but got {actual_modify_dwell_ms!r}"
        )

    def test_enabled_defaults_to_true(self) -> None:
        # Arrange
        config = ResourceLifecycleConfig()
        expected_enabled = True

        # Act
        actual_enabled = config.enabled

        # Assert
        assert (
            actual_enabled == expected_enabled
        ), f"Expected enabled default {expected_enabled!r} but got {actual_enabled!r}"

    def test_parse_lifecycle_config_enabled_defaults_to_true(self) -> None:
        # Arrange
        raw: dict = {}
        expected_enabled = True

        # Act
        config = parse_lifecycle_config(raw)
        actual_enabled = config.enabled

        # Assert
        assert (
            actual_enabled == expected_enabled
        ), f"Expected parsed enabled default {expected_enabled!r} but got {actual_enabled!r}"
