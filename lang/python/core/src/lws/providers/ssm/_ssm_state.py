"""SSM in-memory state classes."""

from __future__ import annotations

import time
from typing import Any

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"


class _Parameter:
    """Represents an SSM parameter."""

    def __init__(
        self,
        name: str,
        value: str,
        param_type: str = "String",
        description: str = "",
        tags: dict[str, str] | None = None,
    ) -> None:
        self.name = name
        self.value = value
        self.type = param_type
        self.description = description
        self.version = 1
        self.tags: dict[str, str] = tags or {}
        self.last_modified_date: float = time.time()
        self.arn = f"arn:aws:ssm:{_REGION}:{_ACCOUNT_ID}:parameter{name}"


class _SsmState:
    """In-memory store for SSM parameters."""

    def __init__(self) -> None:
        self._parameters: dict[str, _Parameter] = {}

    @property
    def parameters(self) -> dict[str, _Parameter]:
        """Return the parameters store."""
        return self._parameters

    def reset(self) -> None:
        """Clear all parameters from the store."""
        self._parameters.clear()


def _format_parameter(param: _Parameter, *, with_decryption: bool = False) -> dict[str, Any]:
    """Format a parameter for API response."""
    value = param.value
    if param.type == "SecureString" and not with_decryption:
        value = "***"
    return {
        "Name": param.name,
        "Type": param.type,
        "Value": value,
        "Version": param.version,
        "LastModifiedDate": param.last_modified_date,
        "ARN": param.arn,
        "DataType": "text",
    }


def _format_parameter_metadata(param: _Parameter) -> dict[str, Any]:
    """Format a parameter for DescribeParameters response."""
    return {
        "Name": param.name,
        "Type": param.type,
        "Description": param.description,
        "Version": param.version,
        "LastModifiedDate": param.last_modified_date,
        "ARN": param.arn,
        "Tier": "Standard",
        "DataType": "text",
    }


def _apply_parameter_filters(
    params_list: list[_Parameter],
    filters: list[dict],
) -> list[_Parameter]:
    """Apply ParameterFilters to a list of parameters."""
    for f in filters:
        key = f.get("Key", "")
        values = f.get("Values", [])
        option = f.get("Option", "Equals")
        if key == "Name":
            params_list = _filter_by_name(params_list, values, option)
    return params_list


def _name_matches_equals(name: str, values: list[str]) -> bool:
    return name in values


def _name_matches_begins_with(name: str, values: list[str]) -> bool:
    return any(name.startswith(v) for v in values)


def _name_matches_contains(name: str, values: list[str]) -> bool:
    return any(v in name for v in values)


_NAME_MATCHERS = {
    "Equals": _name_matches_equals,
    "BeginsWith": _name_matches_begins_with,
    "Contains": _name_matches_contains,
}


def _filter_by_name(
    params_list: list[_Parameter],
    values: list[str],
    option: str,
) -> list[_Parameter]:
    """Filter parameters by name using the given option."""
    matcher = _NAME_MATCHERS.get(option)
    if matcher is None:
        return params_list
    return [p for p in params_list if matcher(p.name, values)]
