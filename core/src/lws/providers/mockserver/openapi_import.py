"""Import OpenAPI 3.x / Swagger 2.x specs to generate mock route files."""

from __future__ import annotations

from pathlib import Path
from typing import Any

import yaml


def import_openapi_spec(
    spec_path: Path,
    output_dir: Path,
    *,
    overwrite: bool = False,
) -> list[str]:
    """Read an OpenAPI spec and generate mock route YAML files.

    Returns a list of generated file paths (relative to *output_dir*).
    """
    raw = yaml.safe_load(spec_path.read_text())
    if raw is None:
        return []

    is_swagger = raw.get("swagger", "").startswith("2.")
    paths = raw.get("paths", {})

    routes_dir = output_dir / "routes"
    routes_dir.mkdir(parents=True, exist_ok=True)

    generated: list[str] = []

    for path, methods in paths.items():
        for method, operation in methods.items():
            if method.lower() in ("parameters", "summary", "description", "servers"):
                continue
            route = _build_route_from_operation(path, method, operation, raw, is_swagger=is_swagger)
            filename = _route_filename(path, method)
            filepath = routes_dir / filename

            if filepath.exists() and not overwrite:
                continue

            content = yaml.dump(
                {"routes": [route]},
                default_flow_style=False,
                sort_keys=False,
            )
            filepath.write_text(content)
            generated.append(str(filepath.relative_to(output_dir)))

    # Copy spec for validation
    spec_dest = output_dir / "spec.yaml"
    if not spec_dest.exists() or overwrite:
        spec_dest.write_text(spec_path.read_text())

    return generated


def _build_route_from_operation(
    path: str,
    method: str,
    operation: dict[str, Any],
    spec: dict[str, Any],
    *,
    is_swagger: bool = False,
) -> dict[str, Any]:
    """Build a route dict from an OpenAPI operation."""
    responses_raw = operation.get("responses", {})
    mock_responses = []

    for status_code, resp_def in responses_raw.items():
        status = int(status_code) if status_code.isdigit() else 200
        body = _extract_example(resp_def, spec, is_swagger=is_swagger)
        mock_responses.append(
            {
                "match": {},
                "status": status,
                "body": body,
            }
        )

    if not mock_responses:
        mock_responses.append({"match": {}, "status": 200, "body": {}})

    return {
        "path": path,
        "method": method.upper(),
        "summary": operation.get("summary", ""),
        "responses": mock_responses,
    }


def _extract_swagger_example(resp_def: dict[str, Any], spec: dict[str, Any]) -> Any:
    """Extract or synthesize a response body from a Swagger 2.x definition."""
    schema = resp_def.get("schema", {})
    if "$ref" in schema:
        schema = _resolve_ref(schema["$ref"], spec)
    example = schema.get("example")
    return example if example is not None else _synthesize_from_schema(schema, spec)


def _extract_openapi3_media_example(media: dict[str, Any], spec: dict[str, Any]) -> Any:
    """Extract or synthesize a response body from an OpenAPI 3.x media type."""
    if "example" in media:
        return media["example"]
    if "examples" in media:
        first = next(iter(media["examples"].values()), {})
        if isinstance(first, dict) and "value" in first:
            return first["value"]
    schema = media.get("schema", {})
    if "$ref" in schema:
        schema = _resolve_ref(schema["$ref"], spec)
    return _synthesize_from_schema(schema, spec)


def _extract_example(
    resp_def: dict[str, Any],
    spec: dict[str, Any],
    *,
    is_swagger: bool = False,
) -> Any:
    """Extract or synthesize a response body from a response definition."""
    if is_swagger:
        return _extract_swagger_example(resp_def, spec)

    content = resp_def.get("content", {})
    for media_type in ("application/json", "application/*", "*/*"):
        if media_type in content:
            return _extract_openapi3_media_example(content[media_type], spec)
    return {}


def _resolve_ref(ref: str, spec: dict[str, Any]) -> dict[str, Any]:
    """Resolve a JSON Reference (``$ref``) within the spec."""
    parts = ref.lstrip("#/").split("/")
    current: Any = spec
    for part in parts:
        if isinstance(current, dict):
            current = current.get(part, {})
        else:
            return {}
    return current if isinstance(current, dict) else {}


_SCALAR_DEFAULTS: dict[str, Any] = {
    "integer": 0,
    "number": 0.0,
    "boolean": False,
}


def _synthesize_from_schema(schema: dict[str, Any], spec: dict[str, Any]) -> Any:
    """Generate a synthetic value from an OpenAPI schema."""
    if "$ref" in schema:
        schema = _resolve_ref(schema["$ref"], spec)

    schema_type = schema.get("type", "object")
    if "example" in schema:
        return schema["example"]

    if schema_type == "string":
        return schema.get("enum", ["string"])[0] if "enum" in schema else "string"
    if schema_type in _SCALAR_DEFAULTS:
        return _SCALAR_DEFAULTS[schema_type]
    if schema_type == "array":
        return [_synthesize_from_schema(schema.get("items", {}), spec)]
    if schema_type == "object":
        props = schema.get("properties", {})
        return {k: _synthesize_from_schema(v, spec) for k, v in props.items()}
    return {}


def _route_filename(path: str, method: str) -> str:
    """Generate a filename for a route file."""
    safe_path = path.strip("/").replace("/", "_").replace("{", "").replace("}", "")
    if not safe_path:
        safe_path = "root"
    return f"{safe_path}_{method.lower()}.yaml"
