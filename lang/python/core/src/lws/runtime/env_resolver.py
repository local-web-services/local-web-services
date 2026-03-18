"""CloudFormation intrinsic function resolution for environment variables.

Resolves a dict of environment variable values that may contain CloudFormation
intrinsic functions (``Ref``, ``Fn::GetAtt``, ``Fn::Join``, ``Fn::Sub``,
``Fn::Select``) against a resource registry mapping logical IDs to their
resolved local values.
"""

from __future__ import annotations

import re


def resolve_env_vars(
    env: dict[str, str | dict | list],
    resource_registry: dict[str, str],
) -> dict[str, str]:
    """Resolve CloudFormation intrinsic functions in environment variable values.

    Args:
        env: Mapping of environment variable names to values.  Values may be
             plain strings or dicts/lists representing CloudFormation intrinsics.
        resource_registry: Mapping of logical IDs (and ``LogicalId.Attribute``
                          keys) to their resolved local values.

    Returns:
        A new dict with all values resolved to plain strings.
    """
    resolved: dict[str, str] = {}
    for key, value in env.items():
        resolved[key] = _resolve_value(value, resource_registry)
    return resolved


def _resolve_value(value: str | dict | list, registry: dict[str, str]) -> str:
    """Resolve a single value that may be a string, intrinsic dict, or list."""
    if isinstance(value, str):
        return value

    if isinstance(value, dict):
        return _resolve_intrinsic(value, registry)

    # Unexpected type -- coerce to string.
    return str(value)


def _resolve_intrinsic(intrinsic: dict, registry: dict[str, str]) -> str:
    """Dispatch resolution for a single CloudFormation intrinsic function dict."""
    if "Ref" in intrinsic:
        return _resolve_ref(intrinsic["Ref"], registry)

    if "Fn::GetAtt" in intrinsic:
        return _resolve_get_att(intrinsic["Fn::GetAtt"], registry)

    if "Fn::Join" in intrinsic:
        return _resolve_join(intrinsic["Fn::Join"], registry)

    if "Fn::Sub" in intrinsic:
        return _resolve_sub(intrinsic["Fn::Sub"], registry)

    if "Fn::Select" in intrinsic:
        return _resolve_select(intrinsic["Fn::Select"], registry)

    # Unknown intrinsic -- return string representation.
    return str(intrinsic)


def _resolve_ref(logical_id: str, registry: dict[str, str]) -> str:
    """Resolve a ``Ref`` intrinsic.  Falls back to the logical ID itself."""
    return registry.get(logical_id, logical_id)


def _resolve_get_att(args: list[str], registry: dict[str, str]) -> str:
    """Resolve a ``Fn::GetAtt`` intrinsic.

    The registry key is ``"LogicalId.Attribute"``.  Falls back to that
    composite key as a placeholder.
    """
    if isinstance(args, list) and len(args) == 2:
        composite_key = f"{args[0]}.{args[1]}"
        return registry.get(composite_key, composite_key)
    return str(args)


def _resolve_join(args: list, registry: dict[str, str]) -> str:
    """Resolve a ``Fn::Join`` intrinsic: ``[delimiter, [values...]]``."""
    if not isinstance(args, list) or len(args) != 2:
        return str(args)

    delimiter = args[0]
    values = args[1]

    if not isinstance(values, list):
        return str(args)

    resolved_parts = [_resolve_value(v, registry) for v in values]
    return delimiter.join(resolved_parts)


def _resolve_sub(args: str | list, registry: dict[str, str]) -> str:
    """Resolve a ``Fn::Sub`` intrinsic.

    Supports both the short form (plain string) and the long form
    ``[template_string, {var: value, ...}]``.  ``${VarName}`` placeholders
    are substituted from the provided mapping and then from the registry.
    """
    if isinstance(args, str):
        return _substitute_vars(args, {}, registry)

    if isinstance(args, list) and len(args) == 2:
        template = args[0]
        local_vars = args[1] if isinstance(args[1], dict) else {}
        # Resolve local var values first.
        resolved_local: dict[str, str] = {}
        for k, v in local_vars.items():
            resolved_local[k] = _resolve_value(v, registry)
        return _substitute_vars(template, resolved_local, registry)

    return str(args)


def _substitute_vars(
    template: str,
    local_vars: dict[str, str],
    registry: dict[str, str],
) -> str:
    """Replace ``${VarName}`` placeholders in *template*."""

    def _replacer(match: re.Match) -> str:
        var_name = match.group(1)
        if var_name in local_vars:
            return local_vars[var_name]
        if var_name in registry:
            return registry[var_name]
        # Unresolvable -- keep logical ID as placeholder.
        return var_name

    return re.sub(r"\$\{([^}]+)}", _replacer, template)


def _resolve_select(args: list, registry: dict[str, str]) -> str:
    """Resolve a ``Fn::Select`` intrinsic: ``[index, [values...]]``."""
    if not isinstance(args, list) or len(args) != 2:
        return str(args)

    index = args[0]
    values = args[1]

    if not isinstance(values, list):
        return str(args)

    try:
        idx = int(index)
    except (TypeError, ValueError):
        return str(args)

    if 0 <= idx < len(values):
        return _resolve_value(values[idx], registry)

    return str(args)
