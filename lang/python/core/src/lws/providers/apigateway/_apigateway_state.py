"""In-memory state dataclasses for API Gateway (V1 and V2)."""

from __future__ import annotations

import json
import time
import uuid
from dataclasses import dataclass, field
from typing import Any

from fastapi import Response


def _json_response(data: dict, status_code: int = 200) -> Response:
    """Return a JSON FastAPI Response."""
    return Response(
        content=json.dumps(data, default=str),
        status_code=status_code,
        media_type="application/json",
    )


def _not_found(resource_type: str, resource_id: str) -> Response:
    """Return a 404 JSON response for a missing resource."""
    return _json_response(
        {"message": f"{resource_type} not found: {resource_id}"},
        status_code=404,
    )


# ---------------------------------------------------------------------------
# V1 (REST API) state
# ---------------------------------------------------------------------------


@dataclass
class _RestApi:
    id: str
    name: str
    description: str = ""
    created_date: float = field(default_factory=time.time)
    root_resource_id: str = field(default_factory=lambda: str(uuid.uuid4())[:10])
    resources: dict[str, dict[str, Any]] = field(default_factory=dict)
    deployments: dict[str, dict[str, Any]] = field(default_factory=dict)
    stages: dict[str, dict[str, Any]] = field(default_factory=dict)
    authorizers: dict[str, dict[str, Any]] = field(default_factory=dict)

    def __post_init__(self) -> None:
        # Every REST API has a root resource "/"
        self.resources[self.root_resource_id] = {
            "id": self.root_resource_id,
            "path": "/",
            "resourceMethods": {},
        }


class _ApiGatewayState:
    """Thread-safe in-memory store for API Gateway resources."""

    def __init__(self) -> None:
        self._apis: dict[str, _RestApi] = {}

    def create_rest_api(self, name: str, description: str = "") -> _RestApi:
        """Create and store a new REST API, returning it."""
        api_id = str(uuid.uuid4())[:10]
        api = _RestApi(id=api_id, name=name, description=description)
        self._apis[api_id] = api
        return api

    def find_by_name(self, name: str) -> _RestApi | None:
        """Return the first REST API with the given name, or None."""
        return next((api for api in self._apis.values() if api.name == name), None)

    def get_rest_api(self, api_id: str) -> _RestApi | None:
        """Return the REST API with the given ID, or None."""
        return self._apis.get(api_id)

    def list_rest_apis(self) -> list[_RestApi]:
        """Return all stored REST APIs."""
        return list(self._apis.values())

    def delete_rest_api(self, api_id: str) -> bool:
        """Delete the REST API with the given ID, returning True if it existed."""
        return self._apis.pop(api_id, None) is not None

    def reset(self) -> None:
        """Clear all stored REST APIs."""
        self._apis.clear()


# ---------------------------------------------------------------------------
# V2 (HTTP API) state
# ---------------------------------------------------------------------------

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"


@dataclass
class _HttpApi:
    api_id: str
    name: str
    protocol_type: str = "HTTP"
    description: str = ""
    created_date: str = field(default_factory=lambda: "2024-01-01T00:00:00Z")
    routes: dict[str, dict[str, Any]] = field(default_factory=dict)
    integrations: dict[str, dict[str, Any]] = field(default_factory=dict)
    stages: dict[str, dict[str, Any]] = field(default_factory=dict)
    cors_configuration: dict[str, Any] | None = None
    authorizers: dict[str, dict[str, Any]] = field(default_factory=dict)


class _ApiGatewayV2State:
    """In-memory store for API Gateway V2 (HTTP API) resources."""

    def __init__(self) -> None:
        self._apis: dict[str, _HttpApi] = {}

    def create_api(self, name: str, protocol_type: str = "HTTP", description: str = "") -> _HttpApi:
        """Create a new HTTP API with a generated ID."""
        api_id = str(uuid.uuid4())[:10]
        api = _HttpApi(
            api_id=api_id, name=name, protocol_type=protocol_type, description=description
        )
        self._apis[api_id] = api
        return api

    def get_api(self, api_id: str) -> _HttpApi | None:
        """Return the HTTP API with the given ID, or None if not found."""
        return self._apis.get(api_id)

    def list_apis(self) -> list[_HttpApi]:
        """Return all stored HTTP APIs."""
        return list(self._apis.values())

    def delete_api(self, api_id: str) -> bool:
        """Delete the HTTP API with the given ID, returning True if it existed."""
        return self._apis.pop(api_id, None) is not None

    def reset(self) -> None:
        """Clear all stored HTTP APIs."""
        self._apis.clear()


def apply_stage_patch_op(stage: dict, op: dict) -> None:
    """Apply a single PATCH replace operation to a stage's defaultRouteSettings."""
    path = op.get("path", "")
    value = op.get("value")
    if op.get("op") != "replace":
        return
    if "defaultRouteSettings" not in stage:
        stage["defaultRouteSettings"] = {}
    if path == "/defaultRouteSettings/throttlingBurstLimit":
        stage["defaultRouteSettings"]["throttlingBurstLimit"] = (
            int(value) if value is not None else None
        )
    elif path == "/defaultRouteSettings/throttlingRateLimit":
        stage["defaultRouteSettings"]["throttlingRateLimit"] = (
            float(value) if value is not None else None
        )
