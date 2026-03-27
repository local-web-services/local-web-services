"""Unit tests: LwsSession.get_injected_state() method."""

from __future__ import annotations

from unittest.mock import MagicMock, patch

from lws_testing.session import LwsSession


class TestGetInjectedState:
    def test_get_injected_state_calls_get_with_correct_url(self):
        # Arrange
        session = LwsSession()
        session._mgmt_port = 19000
        expected_url = "http://127.0.0.1:19000/_ldk/state/lambda/invocation/my-iid"
        mock_response = MagicMock(status_code=200)
        mock_response.json.return_value = {"state": "IN_PROGRESS"}

        # Act
        with patch("httpx.get") as mock_get:
            mock_get.return_value = mock_response
            session.get_injected_state("lambda", "invocation", "my-iid")

        # Assert
        actual_url = mock_get.call_args[0][0]
        assert actual_url == expected_url, f"Expected {expected_url!r} but got {actual_url!r}"

    def test_get_injected_state_returns_state_from_response(self):
        # Arrange
        session = LwsSession()
        session._mgmt_port = 19000
        expected_state = "IN_PROGRESS"
        mock_response = MagicMock(status_code=200)
        mock_response.json.return_value = {"state": expected_state}

        # Act
        with patch("httpx.get") as mock_get:
            mock_get.return_value = mock_response
            actual_state = session.get_injected_state("lambda", "invocation", "my-iid")

        # Assert
        assert (
            actual_state == expected_state
        ), f"Expected {expected_state!r} but got {actual_state!r}"

    def test_get_injected_state_returns_none_when_not_found(self):
        # Arrange
        session = LwsSession()
        session._mgmt_port = 19000
        expected_state = None
        mock_response = MagicMock(status_code=404)

        # Act
        with patch("httpx.get") as mock_get:
            mock_get.return_value = mock_response
            actual_state = session.get_injected_state("lambda", "invocation", "missing-iid")

        # Assert
        assert (
            actual_state == expected_state
        ), f"Expected {expected_state!r} but got {actual_state!r}"
