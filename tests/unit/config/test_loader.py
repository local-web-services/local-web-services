"""Tests for ldk.config.loader."""

from __future__ import annotations

from pathlib import Path

import pytest

from ldk.config.loader import ConfigError, load_config


def test_no_config_file_returns_defaults(tmp_path: Path) -> None:
    """When no ldk.config.py is present, all defaults should be returned."""
    config = load_config(tmp_path)

    assert config.port == 3000
    assert config.persist is True
    assert config.data_dir == ".ldk"
    assert config.log_level == "info"
    assert config.cdk_out_dir == "cdk.out"
    assert config.watch_include == ["src/**", "lib/**"]
    assert config.watch_exclude == ["node_modules/**", ".git/**", "cdk.out/**"]
    assert config.eventual_consistency_delay_ms == 200


def test_valid_config_overrides_all_values(tmp_path: Path) -> None:
    """A config file that sets every value should override all defaults."""
    config_file = tmp_path / "ldk.config.py"
    config_file.write_text(
        "port = 4000\n"
        "persist = False\n"
        'data_dir = ".ldk-custom"\n'
        'log_level = "debug"\n'
        'cdk_out_dir = "out"\n'
        'watch_include = ["app/**"]\n'
        'watch_exclude = ["dist/**"]\n'
        "eventual_consistency_delay_ms = 500\n"
    )

    config = load_config(tmp_path)

    assert config.port == 4000
    assert config.persist is False
    assert config.data_dir == ".ldk-custom"
    assert config.log_level == "debug"
    assert config.cdk_out_dir == "out"
    assert config.watch_include == ["app/**"]
    assert config.watch_exclude == ["dist/**"]
    assert config.eventual_consistency_delay_ms == 500


def test_partial_config_keeps_remaining_defaults(tmp_path: Path) -> None:
    """A config file that only overrides some values should leave the rest as defaults."""
    config_file = tmp_path / "ldk.config.py"
    config_file.write_text('port = 8080\nlog_level = "warning"\n')

    config = load_config(tmp_path)

    # Overridden values
    assert config.port == 8080
    assert config.log_level == "warning"

    # Defaults preserved
    assert config.persist is True
    assert config.data_dir == ".ldk"
    assert config.cdk_out_dir == "cdk.out"
    assert config.watch_include == ["src/**", "lib/**"]
    assert config.watch_exclude == ["node_modules/**", ".git/**", "cdk.out/**"]
    assert config.eventual_consistency_delay_ms == 200


def test_invalid_port_raises_config_error(tmp_path: Path) -> None:
    """A port outside 1-65535 should raise ConfigError."""
    config_file = tmp_path / "ldk.config.py"
    config_file.write_text("port = 99999\n")

    with pytest.raises(ConfigError, match="Invalid port"):
        load_config(tmp_path)


def test_port_zero_raises_config_error(tmp_path: Path) -> None:
    """Port 0 is not valid and should raise ConfigError."""
    config_file = tmp_path / "ldk.config.py"
    config_file.write_text("port = 0\n")

    with pytest.raises(ConfigError, match="Invalid port"):
        load_config(tmp_path)


def test_negative_port_raises_config_error(tmp_path: Path) -> None:
    """A negative port should raise ConfigError."""
    config_file = tmp_path / "ldk.config.py"
    config_file.write_text("port = -1\n")

    with pytest.raises(ConfigError, match="Invalid port"):
        load_config(tmp_path)


def test_invalid_log_level_raises_config_error(tmp_path: Path) -> None:
    """An unrecognised log_level should raise ConfigError."""
    config_file = tmp_path / "ldk.config.py"
    config_file.write_text('log_level = "verbose"\n')

    with pytest.raises(ConfigError, match="Invalid log_level"):
        load_config(tmp_path)


def test_unknown_variables_in_config_are_ignored(tmp_path: Path) -> None:
    """Extra variables in the config file that don't match fields are silently ignored."""
    config_file = tmp_path / "ldk.config.py"
    config_file.write_text('port = 5000\ncustom_setting = "foo"\n')

    config = load_config(tmp_path)

    assert config.port == 5000
    assert not hasattr(config, "custom_setting")
