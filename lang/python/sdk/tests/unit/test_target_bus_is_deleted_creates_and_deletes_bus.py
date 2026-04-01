"""Unit tests: target_bus_is_deleted creates then deletes the event bus."""

from __future__ import annotations

from unittest.mock import MagicMock

from tests.e2e.s3api_events.constants import TEST_BUS
from tests.e2e.s3api_events.given.target_bus_is_deleted import target_bus_is_deleted


class TestTargetBusIsDeletedCreatesAndDeletesBus:
    """target_bus_is_deleted creates and then deletes the event bus."""

    def test_creates_event_bus_before_deleting(self) -> None:
        # Arrange
        mock_events = MagicMock()
        mock_s3 = MagicMock()
        mock_session = MagicMock()

        def client_factory(service):
            if service == "events":
                return mock_events
            return mock_s3

        mock_session.client.side_effect = client_factory
        expected_bus_name = TEST_BUS

        # Act
        target_bus_is_deleted(mock_session)

        # Assert
        actual_create_calls = mock_events.create_event_bus.call_args_list
        assert len(actual_create_calls) >= 1, (
            f"Expected create_event_bus to be called at least once "
            f"but it was called {len(actual_create_calls)} times"
        )
        actual_create_name = actual_create_calls[0][1].get("Name") or actual_create_calls[0][0][0]
        assert actual_create_name == expected_bus_name, (
            f"Expected create_event_bus(Name='{expected_bus_name}') "
            f"but got Name='{actual_create_name}'"
        )

    def test_deletes_event_bus_after_creating(self) -> None:
        # Arrange
        mock_events = MagicMock()
        mock_s3 = MagicMock()
        mock_session = MagicMock()

        def client_factory(service):
            if service == "events":
                return mock_events
            return mock_s3

        mock_session.client.side_effect = client_factory
        expected_bus_name = TEST_BUS

        # Act
        target_bus_is_deleted(mock_session)

        # Assert
        mock_events.delete_event_bus.assert_called_once_with(Name=expected_bus_name)

    def test_delete_called_after_create(self) -> None:
        # Arrange
        call_order = []
        mock_events = MagicMock()
        mock_events.create_event_bus.side_effect = lambda **_: call_order.append("create")
        mock_events.delete_event_bus.side_effect = lambda **_: call_order.append("delete")
        mock_s3 = MagicMock()
        mock_session = MagicMock()

        def client_factory(service):
            if service == "events":
                return mock_events
            return mock_s3

        mock_session.client.side_effect = client_factory
        expected_order = ["create", "delete"]

        # Act
        target_bus_is_deleted(mock_session)

        # Assert
        actual_order = call_order
        assert (
            actual_order == expected_order
        ), f"Expected call order {expected_order} but got {actual_order}"
