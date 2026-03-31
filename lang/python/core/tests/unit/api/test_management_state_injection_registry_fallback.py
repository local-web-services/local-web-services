"""Unit tests for TrackerRegistry dispatch — fallback (unknown service) path."""

from __future__ import annotations

from lws.providers._shared.async_state_store import AsyncStateStore
from lws.providers._shared.aws_lifecycle import TrackerRegistry

from ._helpers import make_registry_client


class TestTrackerRegistryDispatchFallback:
    """Unknown service falls back to AsyncStateStore-only path."""

    def test_inject_state_for_unknown_service_writes_to_store(self):
        # Arrange
        registry: TrackerRegistry = {}
        state_store = AsyncStateStore()
        client = make_registry_client(state_store, tracker_registry=registry)
        expected_state = "ACTIVE"

        # Act
        resp = client.put(
            "/_ldk/state/unknown/widget/some-id",
            json={"state": expected_state},
        )

        # Assert
        assert resp.status_code == 200, f"Expected 200 but got {resp.status_code}"
        actual_state = state_store.get("unknown", "widget", "some-id")
        assert (
            actual_state == expected_state
        ), f"Expected {expected_state!r} but got {actual_state!r}"

    def test_inject_state_for_unknown_service_returns_ok(self):
        # Arrange
        registry: TrackerRegistry = {}
        state_store = AsyncStateStore()
        client = make_registry_client(state_store, tracker_registry=registry)
        expected_status_code = 200

        # Act
        resp = client.put(
            "/_ldk/state/unknown/widget/some-id",
            json={"state": "ACTIVE"},
        )

        # Assert
        assert (
            resp.status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {resp.status_code!r}"
