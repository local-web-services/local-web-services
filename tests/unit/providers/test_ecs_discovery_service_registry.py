"""Tests for ldk.providers.ecs.discovery."""

from __future__ import annotations

from lws.providers.ecs.discovery import ServiceEndpoint, ServiceRegistry

# ---------------------------------------------------------------------------
# ServiceEndpoint tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# ServiceRegistry tests
# ---------------------------------------------------------------------------


class TestServiceRegistry:
    def test_register_and_lookup(self) -> None:
        # Arrange
        expected_port = 8080
        registry = ServiceRegistry()
        ep = ServiceEndpoint(service_name="api", host="localhost", port=expected_port)
        registry.register(ep)

        # Act
        result = registry.lookup("api")

        # Assert
        assert result is not None
        actual_port = result.port
        assert actual_port == expected_port

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
        # Arrange
        expected_port = 9090
        registry = ServiceRegistry()
        ep1 = ServiceEndpoint(service_name="api", host="localhost", port=8080)
        ep2 = ServiceEndpoint(service_name="api", host="localhost", port=expected_port)
        registry.register(ep1)
        registry.register(ep2)

        # Act
        result = registry.lookup("api")

        # Assert
        assert result is not None
        actual_port = result.port
        assert actual_port == expected_port

    def test_build_env_vars(self) -> None:
        # Arrange
        registry = ServiceRegistry()
        registry.register(ServiceEndpoint("web-api", "localhost", 3000))
        registry.register(ServiceEndpoint("worker", "localhost", 4000))

        # Act
        env = registry.build_env_vars()

        # Assert
        expected_web_api_url = "http://localhost:3000"
        expected_worker_url = "http://localhost:4000"
        actual_web_api_url = env["LDK_ECS_WEB_API"]
        actual_worker_url = env["LDK_ECS_WORKER"]
        assert actual_web_api_url == expected_web_api_url
        assert actual_worker_url == expected_worker_url

    def test_build_env_vars_custom_prefix(self) -> None:
        # Arrange
        registry = ServiceRegistry()
        registry.register(ServiceEndpoint("svc", "localhost", 5000))

        # Act
        env = registry.build_env_vars(prefix="MY_")

        # Assert
        expected_url = "http://localhost:5000"
        actual_url = env["MY_SVC"]
        assert actual_url == expected_url

    def test_build_env_vars_empty_registry(self) -> None:
        registry = ServiceRegistry()
        env = registry.build_env_vars()
        assert env == {}
