"""Configuration loader for LDK projects.

Reads configuration from ``ldk.config.py`` or ``ldk.yaml`` in the project
directory and returns an ``LdkConfig`` dataclass with defaults applied for
any values not specified.

Priority order (highest wins): CLI args > env vars > config file > defaults.
"""

from __future__ import annotations

import importlib.util
import json
import os
import sys
from dataclasses import dataclass, field, fields
from pathlib import Path
from typing import Any

VALID_LOG_LEVELS = {"debug", "info", "warning", "error", "critical"}
CONFIG_FILE_NAME = "lws.config.py"
YAML_CONFIG_FILE_NAME = "ldk.yaml"

# Environment variable prefix for LDK config overrides.
_ENV_PREFIX = "LDK_"


class ConfigError(Exception):
    """Raised when configuration values are invalid."""


@dataclass
class IamAuthServiceConfig:
    """Per-service IAM auth configuration."""

    enabled: bool = False
    mode: str | None = None


@dataclass
class IamAuthConfig:
    """IAM authorization middleware configuration."""

    mode: str = "disabled"
    default_identity: str = "admin-user"
    identity_header: str = "X-Lws-Identity"
    services: dict[str, IamAuthServiceConfig] = field(default_factory=dict)


@dataclass
class LdkConfig:
    """LDK project configuration with sensible defaults.

    Supported config keys:
        port, persist, data_dir, log_level, cdk_out_dir,
        watch_include, watch_exclude, eventual_consistency_delay_ms
    """

    port: int = 3000
    persist: bool = True
    data_dir: str = ".ldk"
    log_level: str = "info"
    cdk_out_dir: str = "cdk.out"
    watch_include: list[str] = field(default_factory=lambda: ["src/**", "lib/**"])
    watch_exclude: list[str] = field(
        default_factory=lambda: ["node_modules/**", ".git/**", "cdk.out/**"]
    )
    eventual_consistency_delay_ms: int = 200
    mode: str | None = None
    iam_auth: IamAuthConfig = field(default_factory=IamAuthConfig)


def _validate_config(config: LdkConfig) -> None:
    """Validate configuration values and raise ConfigError for invalid ones."""
    if not isinstance(config.port, int) or not 1 <= config.port <= 65535:
        raise ConfigError(f"Invalid port: {config.port}. Must be an integer between 1 and 65535.")

    if config.log_level.lower() not in VALID_LOG_LEVELS:
        raise ConfigError(
            f"Invalid log_level: {config.log_level!r}. "
            f"Must be one of: {', '.join(sorted(VALID_LOG_LEVELS))}."
        )


def _load_module_from_file(config_path: Path) -> Any:
    """Load a Python module from a file path using importlib."""
    module_name = "ldk_user_config"
    spec = importlib.util.spec_from_file_location(module_name, config_path)
    if spec is None or spec.loader is None:
        raise ConfigError(f"Could not load config file: {config_path}")

    module = importlib.util.module_from_spec(spec)
    # Temporarily add to sys.modules so relative imports work if needed
    sys.modules[module_name] = module
    try:
        spec.loader.exec_module(module)
    except Exception as exc:
        raise ConfigError(f"Error executing config file {config_path}: {exc}") from exc
    finally:
        sys.modules.pop(module_name, None)

    return module


def _parse_yaml_value(value: str) -> Any:
    """Parse a single YAML value string into a Python type.

    Handles booleans, integers, JSON arrays, and quoted strings.
    """
    lower = value.lower()
    if lower in ("true", "yes"):
        return True
    if lower in ("false", "no"):
        return False

    try:
        return int(value)
    except ValueError:
        pass

    if value.startswith("["):
        try:
            return json.loads(value)
        except json.JSONDecodeError:
            pass

    # Strip surrounding quotes
    if len(value) >= 2 and value[0] == value[-1] and value[0] in ('"', "'"):
        return value[1:-1]

    return value


def _load_yaml_config(config_path: Path) -> dict[str, Any]:
    """Load configuration from a YAML file.

    Uses a minimal parser that handles simple key-value YAML without
    requiring PyYAML as a dependency.  For nested keys like
    ``dynamodb.eventual_consistency_delay_ms``, the YAML file uses a flat
    dotted key or a nested mapping.
    """
    try:
        text = config_path.read_text()
    except OSError as exc:
        raise ConfigError(f"Could not read config file: {config_path}: {exc}") from exc

    result: dict[str, Any] = {}
    for line in text.splitlines():
        stripped = line.strip()
        if not stripped or stripped.startswith("#"):
            continue
        if ":" not in stripped:
            continue
        key, _, value = stripped.partition(":")
        key = key.strip()
        value = value.strip()
        result[key] = _parse_yaml_value(value)

    return result


def _flatten_yaml_to_config(yaml_data: dict[str, Any]) -> dict[str, Any]:
    """Map YAML keys (possibly nested/dotted) to LdkConfig field names.

    Supports:
        - Direct field names: ``port: 4000``
        - Dotted nested keys: ``dynamodb.eventual_consistency_delay_ms: 100``
        - Nested ``watch`` keys: ``watch.include`` and ``watch.exclude``
    """
    known_fields = {f.name for f in fields(LdkConfig)}
    result: dict[str, Any] = {}

    # Dotted key mappings
    _KEY_MAP = {
        "dynamodb.eventual_consistency_delay_ms": "eventual_consistency_delay_ms",
        "watch.include": "watch_include",
        "watch.exclude": "watch_exclude",
    }

    for key, value in yaml_data.items():
        mapped_key = _KEY_MAP.get(key, key)
        if mapped_key in known_fields:
            result[mapped_key] = value

    return result


def _coerce_int(value: str) -> Any:
    """Coerce an environment variable string to int, or None on failure."""
    try:
        return int(value)
    except ValueError:
        return None


def _coerce_bool(value: str) -> bool:
    """Coerce an environment variable string to bool."""
    return value.lower() in ("true", "1", "yes")


def _coerce_list(value: str) -> list[str]:
    """Coerce a comma-separated environment variable string to a list."""
    return [p.strip() for p in value.split(",") if p.strip()]


def _get_env_coercer(field_name: str) -> callable:
    """Return the coercion function for a given config field name."""
    if field_name == "port" or field_name.endswith("_ms"):
        return _coerce_int
    if field_name == "persist":
        return _coerce_bool
    if field_name.startswith("watch_"):
        return _coerce_list
    return lambda v: v


def _apply_env_overrides(overrides: dict[str, Any]) -> dict[str, Any]:
    """Apply environment variable overrides.

    Environment variables are prefixed with ``LDK_`` and use uppercase
    field names (e.g. ``LDK_PORT=4000``, ``LDK_LOG_LEVEL=debug``).
    """
    known_fields = {f.name for f in fields(LdkConfig)}
    for field_name in known_fields:
        env_key = f"{_ENV_PREFIX}{field_name.upper()}"
        env_value = os.environ.get(env_key)
        if env_value is not None:
            coerced = _get_env_coercer(field_name)(env_value)
            if coerced is not None:
                overrides[field_name] = coerced

    return overrides


def load_config(project_dir: Path) -> LdkConfig:
    """Load LDK configuration from a project directory.

    Searches for ``ldk.config.py`` first, then ``ldk.yaml``.  Environment
    variables (``LDK_PORT``, ``LDK_LOG_LEVEL``, etc.) override file-based
    config.  CLI arguments override everything (applied by the caller).

    Priority: CLI args > env vars > config file > defaults.

    Args:
        project_dir: Path to the project root directory.

    Returns:
        A fully-populated LdkConfig instance.

    Raises:
        ConfigError: If the config file exists but contains invalid values.
    """
    overrides: dict[str, Any] = {}

    # 1. Try ldk.config.py
    py_config_path = project_dir / CONFIG_FILE_NAME
    if py_config_path.exists():
        module = _load_module_from_file(py_config_path)
        known_fields = {f.name for f in fields(LdkConfig)}
        for name in known_fields:
            if hasattr(module, name):
                overrides[name] = getattr(module, name)
    else:
        # 2. Try ldk.yaml
        yaml_config_path = project_dir / YAML_CONFIG_FILE_NAME
        if yaml_config_path.exists():
            yaml_data = _load_yaml_config(yaml_config_path)
            overrides = _flatten_yaml_to_config(yaml_data)

    # 3. Apply env var overrides (higher priority than file)
    overrides = _apply_env_overrides(overrides)

    config = LdkConfig(**overrides)
    _validate_config(config)

    # 4. Parse iam_auth section from ldk.yaml (requires full YAML parser)
    yaml_config_path = project_dir / YAML_CONFIG_FILE_NAME
    if yaml_config_path.exists():
        config.iam_auth = _load_iam_auth_config(yaml_config_path)

    return config


def _load_iam_auth_config(yaml_path: Path) -> IamAuthConfig:
    """Parse the ``iam_auth`` section from a ldk.yaml file.

    Uses PyYAML for full nested YAML support.  Returns the default
    config if PyYAML is not installed or the section is absent.
    """
    try:
        import yaml  # pylint: disable=import-outside-toplevel
    except ImportError:
        return IamAuthConfig()

    try:
        with open(yaml_path, encoding="utf-8") as fh:
            data = yaml.safe_load(fh)
    except Exception:
        return IamAuthConfig()

    if not isinstance(data, dict):
        return IamAuthConfig()

    raw = data.get("iam_auth")
    if not isinstance(raw, dict):
        return IamAuthConfig()

    services: dict[str, IamAuthServiceConfig] = {}
    for svc_name, svc_raw in raw.get("services", {}).items():
        if isinstance(svc_raw, dict):
            services[svc_name] = IamAuthServiceConfig(
                enabled=svc_raw.get("enabled", False),
                mode=svc_raw.get("mode"),
            )

    return IamAuthConfig(
        mode=raw.get("mode", "disabled"),
        default_identity=raw.get("default_identity", "admin-user"),
        identity_header=raw.get("identity_header", "X-Lws-Identity"),
        services=services,
    )
