"""Tests for ldk.providers.ecs.discovery."""

from __future__ import annotations

import pytest

from ldk.providers.ecs.discovery import ServiceEndpoint

# ---------------------------------------------------------------------------
# ServiceEndpoint tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# ServiceRegistry tests
# ---------------------------------------------------------------------------


class TestServiceEndpoint:
    def test_url_property(self) -> None:
        ep = ServiceEndpoint(service_name="web", host="localhost", port=3000)
        assert ep.url == "http://localhost:3000"

    def test_frozen_dataclass(self) -> None:
        ep = ServiceEndpoint(service_name="web", host="localhost", port=3000)
        with pytest.raises(AttributeError):
            ep.port = 4000  # type: ignore[misc]
