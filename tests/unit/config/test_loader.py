"""Tests for ldk.config.loader."""

from __future__ import annotations

from pathlib import Path

import pytest

from lws.config.loader import ConfigError, load_config


def test_no_config_file_returns_defaults(tmp_path: Path) -> None:
    """When no ldk.config.py is present, all defaults should be returned."""
    # Arrange
    expected_port = 3000
    expected_data_dir = ".ldk"
    expected_log_level = "info"
    expected_cdk_out_dir = "cdk.out"
    expected_watch_include = ["src/**", "lib/**"]
    expected_watch_exclude = ["node_modules/**", ".git/**", "cdk.out/**"]
    expected_delay_ms = 200

    # Act
    config = load_config(tmp_path)

    # Assert
    assert config.port == expected_port
    assert config.persist is True
    assert config.data_dir == expected_data_dir
    assert config.log_level == expected_log_level
    assert config.cdk_out_dir == expected_cdk_out_dir
    assert config.watch_include == expected_watch_include
    assert config.watch_exclude == expected_watch_exclude
    assert config.eventual_consistency_delay_ms == expected_delay_ms


def test_valid_config_overrides_all_values(tmp_path: Path) -> None:
    """A config file that sets every value should override all defaults."""
    # Arrange
    expected_port = 4000
    expected_data_dir = ".ldk-custom"
    expected_log_level = "debug"
    expected_cdk_out_dir = "out"
    expected_watch_include = ["app/**"]
    expected_watch_exclude = ["dist/**"]
    expected_delay_ms = 500

    config_file = tmp_path / "lws.config.py"
    config_file.write_text(
        f"port = {expected_port}\n"
        "persist = False\n"
        f'data_dir = "{expected_data_dir}"\n'
        f'log_level = "{expected_log_level}"\n'
        f'cdk_out_dir = "{expected_cdk_out_dir}"\n'
        f'watch_include = ["{expected_watch_include[0]}"]\n'
        f'watch_exclude = ["{expected_watch_exclude[0]}"]\n'
        f"eventual_consistency_delay_ms = {expected_delay_ms}\n"
    )

    # Act
    config = load_config(tmp_path)

    # Assert
    assert config.port == expected_port
    assert config.persist is False
    assert config.data_dir == expected_data_dir
    assert config.log_level == expected_log_level
    assert config.cdk_out_dir == expected_cdk_out_dir
    assert config.watch_include == expected_watch_include
    assert config.watch_exclude == expected_watch_exclude
    assert config.eventual_consistency_delay_ms == expected_delay_ms


def test_partial_config_keeps_remaining_defaults(tmp_path: Path) -> None:
    """A config file that only overrides some values should leave the rest as defaults."""
    # Arrange
    expected_port = 8080
    expected_log_level = "warning"
    expected_default_data_dir = ".ldk"
    expected_default_cdk_out_dir = "cdk.out"
    expected_default_watch_include = ["src/**", "lib/**"]
    expected_default_watch_exclude = ["node_modules/**", ".git/**", "cdk.out/**"]
    expected_default_delay_ms = 200

    config_file = tmp_path / "lws.config.py"
    config_file.write_text(f'port = {expected_port}\nlog_level = "{expected_log_level}"\n')

    # Act
    config = load_config(tmp_path)

    # Assert -- overridden values
    assert config.port == expected_port
    assert config.log_level == expected_log_level

    # Assert -- defaults preserved
    assert config.persist is True
    assert config.data_dir == expected_default_data_dir
    assert config.cdk_out_dir == expected_default_cdk_out_dir
    assert config.watch_include == expected_default_watch_include
    assert config.watch_exclude == expected_default_watch_exclude
    assert config.eventual_consistency_delay_ms == expected_default_delay_ms


def test_invalid_port_raises_config_error(tmp_path: Path) -> None:
    """A port outside 1-65535 should raise ConfigError."""
    # Arrange
    config_file = tmp_path / "lws.config.py"
    config_file.write_text("port = 99999\n")

    # Act / Assert
    with pytest.raises(ConfigError, match="Invalid port"):
        load_config(tmp_path)


def test_port_zero_raises_config_error(tmp_path: Path) -> None:
    """Port 0 is not valid and should raise ConfigError."""
    # Arrange
    config_file = tmp_path / "lws.config.py"
    config_file.write_text("port = 0\n")

    # Act / Assert
    with pytest.raises(ConfigError, match="Invalid port"):
        load_config(tmp_path)


def test_negative_port_raises_config_error(tmp_path: Path) -> None:
    """A negative port should raise ConfigError."""
    # Arrange
    config_file = tmp_path / "lws.config.py"
    config_file.write_text("port = -1\n")

    # Act / Assert
    with pytest.raises(ConfigError, match="Invalid port"):
        load_config(tmp_path)


def test_invalid_log_level_raises_config_error(tmp_path: Path) -> None:
    """An unrecognised log_level should raise ConfigError."""
    # Arrange
    config_file = tmp_path / "lws.config.py"
    config_file.write_text('log_level = "verbose"\n')

    # Act / Assert
    with pytest.raises(ConfigError, match="Invalid log_level"):
        load_config(tmp_path)


def test_unknown_variables_in_config_are_ignored(tmp_path: Path) -> None:
    """Extra variables in the config file that don't match fields are silently ignored."""
    # Arrange
    expected_port = 5000
    config_file = tmp_path / "lws.config.py"
    config_file.write_text(f'port = {expected_port}\ncustom_setting = "foo"\n')

    # Act
    config = load_config(tmp_path)

    # Assert
    assert config.port == expected_port
    assert not hasattr(config, "custom_setting")
