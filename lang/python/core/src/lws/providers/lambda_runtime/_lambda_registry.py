"""Lambda registry for mapping function names to ICompute instances."""

from __future__ import annotations

from typing import Any


class LambdaRegistry:
    """Maps Lambda function names to live ICompute instances."""

    def __init__(self) -> None:
        self._functions: dict[str, dict[str, Any]] = {}
        self._compute: dict[str, Any] = {}
        self._tags: dict[str, dict[str, str]] = {}
        self._function_urls: dict[str, dict[str, Any]] = {}
        self._function_url_providers: dict[str, Any] = {}

    @property
    def functions(self) -> dict[str, dict[str, Any]]:
        """Return the functions store."""
        return self._functions

    @property
    def compute(self) -> dict[str, Any]:
        """Return the compute providers store."""
        return self._compute

    def register(self, name: str, config: dict[str, Any], compute: Any) -> None:
        """Store a function configuration and its compute provider by name."""
        self._functions[name] = config
        self._compute[name] = compute

    def update_config(self, name: str, updates: dict[str, Any]) -> dict[str, Any] | None:
        """Merge updates into an existing function config, returning the result or None."""
        config = self._functions.get(name)
        if config is None:
            return None
        config.update(updates)
        return config

    def get_config(self, name: str) -> dict[str, Any] | None:
        """Return the stored configuration for a function, or None if not found."""
        return self._functions.get(name)

    def get_compute(self, name: str) -> Any | None:
        """Return the ICompute instance for a function, or None if not found."""
        return self._compute.get(name)

    def delete(self, name: str) -> bool:
        """Remove a function and its compute provider, returning True if it existed."""
        removed = name in self._functions
        self._functions.pop(name, None)
        self._compute.pop(name, None)
        return removed

    def list_functions(self) -> list[dict[str, Any]]:
        """Return all stored function configurations."""
        return list(self._functions.values())

    def get_tags(self, arn: str) -> dict[str, str]:
        """Return a copy of the tags associated with the given ARN."""
        return dict(self._tags.get(arn, {}))

    def tag_resource(self, arn: str, tags: dict[str, str]) -> None:
        """Add or overwrite tags on the resource identified by ARN."""
        self._tags.setdefault(arn, {}).update(tags)

    def untag_resource(self, arn: str, tag_keys: list[str]) -> None:
        """Remove the specified tag keys from the resource identified by ARN."""
        if arn in self._tags:
            for key in tag_keys:
                self._tags[arn].pop(key, None)

    @property
    def function_urls(self) -> dict[str, dict[str, Any]]:
        """Return the function URL config store."""
        return self._function_urls

    @property
    def function_url_providers(self) -> dict[str, Any]:
        """Return the function URL provider store."""
        return self._function_url_providers

    def register_function_url(
        self, function_name: str, url_config: dict[str, Any], provider: Any = None
    ) -> None:
        """Register a Function URL configuration and optional provider."""
        self._function_urls[function_name] = url_config
        if provider is not None:
            self._function_url_providers[function_name] = provider

    def get_function_url(self, function_name: str) -> dict[str, Any] | None:
        """Return the Function URL config for a function, or None."""
        return self._function_urls.get(function_name)

    def delete_function_url(self, function_name: str) -> bool:
        """Remove a Function URL config and provider. Returns True if existed."""
        removed = function_name in self._function_urls
        self._function_urls.pop(function_name, None)
        self._function_url_providers.pop(function_name, None)
        return removed

    def list_function_urls(self) -> list[dict[str, Any]]:
        """Return all Function URL configurations."""
        return list(self._function_urls.values())
