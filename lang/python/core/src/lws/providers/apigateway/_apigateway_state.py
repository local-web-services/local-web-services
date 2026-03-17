"""In-memory state dataclasses for API Gateway (V1 and V2)."""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from typing import Any

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
        """Create a new REST API with a generated ID and root resource."""
        api_id = str(uuid.uuid4())[:10]
        api = _RestApi(id=api_id, name=name, description=description)
        self._apis[api_id] = api
        return api

    def get_rest_api(self, api_id: str) -> _RestApi | None:
        """Return the REST API with the given ID, or None if not found."""
        return self._apis.get(api_id)

    def list_rest_apis(self) -> list[_RestApi]:
        """Return all stored REST APIs."""
        return list(self._apis.values())

    def delete_rest_api(self, api_id: str) -> bool:
        """Delete the REST API with the given ID, returning True if it existed."""
        return self._apis.pop(api_id, None) is not None


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
