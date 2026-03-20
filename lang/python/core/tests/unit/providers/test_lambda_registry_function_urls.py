"""Tests for LambdaRegistry Function URL management methods."""

from __future__ import annotations

from lws.providers.lambda_runtime.routes import LambdaRegistry


class TestLambdaRegistryFunctionUrls:
    def test_register_and_get_function_url(self):
        # Arrange
        registry = LambdaRegistry()
        function_name = "my-handler"
        expected_auth = "NONE"
        url_config = {"FunctionName": function_name, "AuthType": expected_auth}

        # Act
        registry.register_function_url(function_name, url_config)
        result = registry.get_function_url(function_name)

        # Assert
        actual_auth = result["AuthType"]
        assert actual_auth == expected_auth, f"Expected {expected_auth!r} but got {actual_auth!r}"

    def test_get_nonexistent_function_url(self):
        # Arrange
        registry = LambdaRegistry()

        # Act
        result = registry.get_function_url("nonexistent")

        # Assert
        assert result is None, f"Expected None but got {result!r}"

    def test_delete_function_url(self):
        # Arrange
        registry = LambdaRegistry()
        function_name = "to-delete"
        registry.register_function_url(function_name, {"FunctionName": function_name})

        # Act
        removed = registry.delete_function_url(function_name)

        # Assert
        assert removed is True, "Expected value to be truthy"
        assert (
            registry.get_function_url(function_name) is None
        ), f"Expected None but got {registry.get_function_url(function_name)!r}"

    def test_delete_nonexistent_function_url(self):
        # Arrange
        registry = LambdaRegistry()

        # Act
        removed = registry.delete_function_url("nonexistent")

        # Assert
        assert removed is False, "Expected value to be truthy"

    def test_list_function_urls(self):
        # Arrange
        registry = LambdaRegistry()
        registry.register_function_url("fn1", {"FunctionName": "fn1"})
        registry.register_function_url("fn2", {"FunctionName": "fn2"})

        # Act
        result = registry.list_function_urls()

        # Assert
        assert len(result) == 2, f"Expected {2!r} but got {len(result)!r}"

    def test_list_function_urls_empty(self):
        # Arrange
        registry = LambdaRegistry()

        # Act
        result = registry.list_function_urls()

        # Assert
        assert result == [], f"Expected {[]!r} but got {result!r}"

    def test_register_with_provider(self):
        # Arrange
        registry = LambdaRegistry()
        function_name = "with-provider"
        fake_provider = object()
        url_config = {"FunctionName": function_name}

        # Act
        registry.register_function_url(function_name, url_config, fake_provider)

        # Assert
        assert (
            registry.function_url_providers[function_name] is fake_provider
        ), "Expected value to be truthy"

    def test_delete_removes_provider(self):
        # Arrange
        registry = LambdaRegistry()
        function_name = "with-provider"
        fake_provider = object()
        registry.register_function_url(
            function_name, {"FunctionName": function_name}, fake_provider
        )

        # Act
        registry.delete_function_url(function_name)

        # Assert
        assert (
            function_name not in registry.function_url_providers
        ), f"Expected {function_name!r} to not be in {registry.function_url_providers!r}"
