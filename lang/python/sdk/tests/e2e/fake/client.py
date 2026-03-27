"""Test client helpers for fake server e2e tests."""

from __future__ import annotations

from .constants import (
    TEST_ROUTE_BODY,
    TEST_ROUTE_METHOD,
    TEST_ROUTE_PATH,
    TEST_ROUTE_STATUS,
    TEST_SERVER_NAME,
)


class FakeTestClient:
    """Helper wrapping ``lws_session.client("fake")`` for e2e test setup."""

    def __init__(self, lws_session) -> None:
        self._client = lws_session.client("fake")

    def create_server(self) -> dict:
        """Create the test fake server, silently ignoring if it already exists."""
        try:
            return self._client.create_server(TEST_SERVER_NAME)
        except ValueError:
            return {}

    def delete_server(self) -> None:
        """Delete the test fake server."""
        self._client.delete_server(TEST_SERVER_NAME)

    def add_route(self) -> dict:
        """Add the test route to the fake server, silently ignoring if it already exists."""
        try:
            return self._client.add_route(
                TEST_SERVER_NAME,
                TEST_ROUTE_METHOD,
                TEST_ROUTE_PATH,
                status=TEST_ROUTE_STATUS,
                body=TEST_ROUTE_BODY,
            )
        except ValueError:
            return {}

    def remove_route(self) -> None:
        """Remove the test route from the fake server."""
        self._client.remove_route(TEST_SERVER_NAME, TEST_ROUTE_METHOD, TEST_ROUTE_PATH)

    def get_status(self) -> dict:
        """Return status of the test fake server."""
        return self._client.get_status(TEST_SERVER_NAME)

    def set_chaos(self, enabled: bool) -> dict:
        """Enable or disable chaos on the test fake server."""
        return self._client.set_chaos(TEST_SERVER_NAME, enabled=enabled, error_rate=0.5)
