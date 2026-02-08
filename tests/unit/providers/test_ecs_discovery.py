"""Tests for ldk.providers.ecs.discovery."""

from __future__ import annotations

import pytest

from ldk.providers.ecs.discovery import ServiceEndpoint, ServiceRegistry

# ---------------------------------------------------------------------------
# ServiceEndpoint tests
# ---------------------------------------------------------------------------


class TestServiceEndpoint:
    def test_url_property(self) -> None:
        ep = ServiceEndpoint(service_name="web", host="localhost", port=3000)
        assert ep.url == "http://localhost:3000"

    def test_frozen_dataclass(self) -> None:
        ep = ServiceEndpoint(service_name="web", host="localhost", port=3000)
        with pytest.raises(AttributeError):
            ep.port = 4000  # type: ignore[misc]


# ---------------------------------------------------------------------------
# ServiceRegistry tests
# ---------------------------------------------------------------------------


class TestServiceRegistry:
    def test_register_and_lookup(self) -> None:
        registry = ServiceRegistry()
        ep = ServiceEndpoint(service_name="api", host="localhost", port=8080)
        registry.register(ep)

        result = registry.lookup("api")
        assert result is not None
        assert result.port == 8080

    def test_lookup_missing_returns_none(self) -> None:
        registry = ServiceRegistry()
        assert registry.lookup("nonexistent") is None

    def test_deregister_removes_service(self) -> None:
        registry = ServiceRegistry()
        ep = ServiceEndpoint(service_name="api", host="localhost", port=8080)
        registry.register(ep)
        registry.deregister("api")

        assert registry.lookup("api") is None

    def test_deregister_missing_is_safe(self) -> None:
        registry = ServiceRegistry()
        registry.deregister("nonexistent")  # should not raise

    def test_all_endpoints_returns_snapshot(self) -> None:
        registry = ServiceRegistry()
        ep1 = ServiceEndpoint(service_name="api", host="localhost", port=8080)
        ep2 = ServiceEndpoint(service_name="web", host="localhost", port=3000)
        registry.register(ep1)
        registry.register(ep2)

        endpoints = registry.all_endpoints()
        assert len(endpoints) == 2
        assert "api" in endpoints
        assert "web" in endpoints

    def test_all_endpoints_is_copy(self) -> None:
        registry = ServiceRegistry()
        ep = ServiceEndpoint(service_name="api", host="localhost", port=8080)
        registry.register(ep)

        endpoints = registry.all_endpoints()
        endpoints.clear()  # should not affect internal state

        assert registry.lookup("api") is not None

    def test_re_register_updates_endpoint(self) -> None:
        registry = ServiceRegistry()
        ep1 = ServiceEndpoint(service_name="api", host="localhost", port=8080)
        ep2 = ServiceEndpoint(service_name="api", host="localhost", port=9090)
        registry.register(ep1)
        registry.register(ep2)

        result = registry.lookup("api")
        assert result is not None
        assert result.port == 9090

    def test_build_env_vars(self) -> None:
        registry = ServiceRegistry()
        registry.register(ServiceEndpoint("web-api", "localhost", 3000))
        registry.register(ServiceEndpoint("worker", "localhost", 4000))

        env = registry.build_env_vars()
        assert env["LDK_ECS_WEB_API"] == "http://localhost:3000"
        assert env["LDK_ECS_WORKER"] == "http://localhost:4000"

    def test_build_env_vars_custom_prefix(self) -> None:
        registry = ServiceRegistry()
        registry.register(ServiceEndpoint("svc", "localhost", 5000))

        env = registry.build_env_vars(prefix="MY_")
        assert env["MY_SVC"] == "http://localhost:5000"

    def test_build_env_vars_empty_registry(self) -> None:
        registry = ServiceRegistry()
        env = registry.build_env_vars()
        assert env == {}
