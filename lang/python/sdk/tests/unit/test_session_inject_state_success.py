"""Unit tests: LwsSession.inject_state() method."""

from __future__ import annotations

from unittest.mock import MagicMock, patch

from lws_testing.session import LwsSession


def test_inject_state_calls_put_with_correct_url():
    # Arrange
    session = LwsSession()
    session._mgmt_port = 19000
    expected_url = "http://127.0.0.1:19000/_ldk/state/stepfunctions/execution/my-exec"

    # Act
    with patch("httpx.put") as mock_put:
        mock_put.return_value = MagicMock(status_code=200)
        session.inject_state("stepfunctions", "execution", "my-exec", "RUNNING")

    # Assert
    actual_url = mock_put.call_args[0][0]
    assert actual_url == expected_url, f"Expected {expected_url!r} but got {actual_url!r}"


def test_inject_state_sends_state_in_json_body():
    # Arrange
    session = LwsSession()
    session._mgmt_port = 19000
    expected_state = "RUNNING"

    # Act
    with patch("httpx.put") as mock_put:
        mock_put.return_value = MagicMock(status_code=200)
        session.inject_state("stepfunctions", "execution", "my-exec", expected_state)

    # Assert
    actual_body = mock_put.call_args[1]["json"]
    assert (
        actual_body["state"] == expected_state
    ), f"Expected {expected_state!r} but got {actual_body['state']!r}"
