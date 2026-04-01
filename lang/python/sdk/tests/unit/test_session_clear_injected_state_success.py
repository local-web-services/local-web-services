"""Unit tests: LwsSession.clear_injected_state() method."""

from __future__ import annotations

from unittest.mock import MagicMock, patch

from lws_testing.session import LwsSession


def test_clear_injected_state_calls_delete_with_correct_url():
    # Arrange
    session = LwsSession()
    session._mgmt_port = 19000
    expected_url = "http://127.0.0.1:19000/_ldk/state/stepfunctions/execution/my-exec"

    # Act
    with patch("httpx.delete") as mock_delete:
        mock_delete.return_value = MagicMock(status_code=200)
        session.clear_injected_state("stepfunctions", "execution", "my-exec")

    # Assert
    actual_url = mock_delete.call_args[0][0]
    assert actual_url == expected_url, f"Expected {expected_url!r} but got {actual_url!r}"
