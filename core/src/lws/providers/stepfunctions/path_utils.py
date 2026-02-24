"""JSONPath-like path utilities for Step Functions state processing.

Implements InputPath, OutputPath, ResultPath, and Parameters processing
using a simple JSONPath-like path extraction.
"""

from __future__ import annotations

import copy
from typing import Any


def apply_input_path(data: Any, path: str | None) -> Any:
    """Apply InputPath to extract a subset of the input."""
    if path is None:
        return {}
    if path == "$":
        return data
    return resolve_path(data, path)


def apply_output_path(data: Any, path: str | None) -> Any:
    """Apply OutputPath to extract a subset of the output."""
    if path is None:
        return {}
    if path == "$":
        return data
    return resolve_path(data, path)


def apply_result_path(original_input: Any, result: Any, result_path: str | None) -> Any:
    """Apply ResultPath to place the result into the original input.

    If result_path is None, discard the result and return the original input.
    If result_path is "$", replace the entire input with the result.
    Otherwise, set the result at the specified path within a copy of the input.
    """
    if result_path is None:
        return original_input
    if result_path == "$":
        return result
    return _set_at_path(original_input, result_path, result)


def resolve_path(data: Any, path: str) -> Any:
    """Resolve a JSONPath-like reference path against data.

    Supports paths like:
    - $ (root)
    - $.key
    - $.key.nested
    - $.array[0]
    """
    if path == "$":
        return data
    if not path.startswith("$."):
        return data

    segments = _parse_path_segments(path[2:])
    return _walk_segments(data, segments)


def _parse_path_segments(path_str: str) -> list[str | int]:
    """Parse a dot-separated path string into segments, handling array indices."""
    segments: list[str | int] = []
    for part in path_str.split("."):
        if not part:
            continue
        if "[" in part:
            _parse_bracketed_segment(part, segments)
        else:
            segments.append(part)
    return segments


def _parse_bracketed_segment(part: str, segments: list[str | int]) -> None:
    """Parse a segment containing array bracket notation like 'items[0]'."""
    bracket_pos = part.index("[")
    key = part[:bracket_pos]
    if key:
        segments.append(key)
    idx_str = part[bracket_pos + 1 : part.index("]")]
    segments.append(int(idx_str))


def _walk_segments(data: Any, segments: list[str | int]) -> Any:
    """Walk through data following the given path segments."""
    current = data
    for segment in segments:
        if isinstance(segment, int):
            current = current[segment]
        elif isinstance(current, dict):
            current = current[segment]
        else:
            raise KeyError(f"Cannot resolve segment '{segment}' in {type(current)}")
    return current


def _set_at_path(data: Any, path: str, value: Any) -> Any:
    """Set a value at a JSONPath-like location within data."""
    if not path.startswith("$."):
        return data

    result = copy.deepcopy(data) if isinstance(data, (dict, list)) else data
    if not isinstance(result, dict):
        result = {}

    segments = _parse_path_segments(path[2:])
    if not segments:
        return value

    _set_nested(result, segments, value)
    return result


def _set_nested(data: dict, segments: list[str | int], value: Any) -> None:
    """Set a value at the nested path specified by segments."""
    current: Any = data
    for i, segment in enumerate(segments[:-1]):
        next_seg = segments[i + 1]
        current = _ensure_container(current, segment, next_seg)

    last = segments[-1]
    if isinstance(last, int) and isinstance(current, list):
        while len(current) <= last:
            current.append(None)
        current[last] = value
    elif isinstance(current, dict) and isinstance(last, str):
        current[last] = value


def _ensure_container(current: Any, segment: str | int, next_seg: str | int) -> Any:
    """Ensure a nested container exists at the given segment."""
    if isinstance(segment, str) and isinstance(current, dict):
        if segment not in current or not isinstance(current[segment], (dict, list)):
            current[segment] = [] if isinstance(next_seg, int) else {}
        return current[segment]
    if isinstance(segment, int) and isinstance(current, list):
        while len(current) <= segment:
            current.append({})
        return current[segment]
    return current


def apply_parameters(parameters: dict[str, Any], input_data: Any) -> dict[str, Any]:
    """Apply Parameters template, resolving .$ suffix JSONPath references."""
    result: dict[str, Any] = {}
    for key, value in parameters.items():
        resolved_key, resolved_value = _resolve_parameter_entry(key, value, input_data)
        result[resolved_key] = resolved_value
    return result


def _resolve_parameter_entry(key: str, value: Any, input_data: Any) -> tuple[str, Any]:
    """Resolve a single parameter entry, handling .$ suffix and nested dicts."""
    if key.endswith(".$"):
        actual_key = key[:-2]
        resolved = resolve_path(input_data, value) if isinstance(value, str) else value
        return actual_key, resolved
    if isinstance(value, dict):
        return key, apply_parameters(value, input_data)
    return key, value


def apply_context_parameters(
    parameters: dict[str, Any],
    input_data: Any,
    context: dict[str, Any],
) -> dict[str, Any]:
    """Apply Parameters template with context object ($$ references)."""
    result: dict[str, Any] = {}
    for key, value in parameters.items():
        resolved_key, resolved_value = _resolve_context_entry(key, value, input_data, context)
        result[resolved_key] = resolved_value
    return result


def _resolve_context_entry(
    key: str,
    value: Any,
    input_data: Any,
    context: dict[str, Any],
) -> tuple[str, Any]:
    """Resolve a single parameter entry, supporting both $ and $$ references."""
    if not key.endswith(".$"):
        if isinstance(value, dict):
            return key, apply_context_parameters(value, input_data, context)
        return key, value

    actual_key = key[:-2]
    if isinstance(value, str) and value.startswith("$$"):
        resolved = _resolve_context_path(value, context)
    elif isinstance(value, str):
        resolved = resolve_path(input_data, value)
    else:
        resolved = value
    return actual_key, resolved


def _resolve_context_path(path: str, context: dict[str, Any]) -> Any:
    """Resolve a $$ context path reference."""
    if path == "$$":
        return context
    context_path = "$" + path[2:]
    return resolve_path(context, context_path)
