"""Unit tests: LwsSession.inject_state() skips on 404 not-tracked response."""

from __future__ import annotations

from unittest.mock import MagicMock, patch

import pytest

from lws_testing.session import LwsSession


def test_inject_state_skips_when_resource_not_tracked():
    # Arrange
    session = LwsSession()
    session._mgmt_port = 19000
    mock_response = MagicMock(status_code=404, text='{"error": "cluster \'my-id\' is not tracked"}')

    # Act / Assert
    with patch("httpx.put", return_value=mock_response):
        with pytest.raises(pytest.skip.Exception):
            session.inject_state("elasticache", "cluster", "my-id", "modifying")


def test_inject_state_skip_message_includes_resource_path():
    # Arrange
    session = LwsSession()
    session._mgmt_port = 19000
    mock_response = MagicMock(status_code=404, text='{"error": "cluster \'my-id\' is not tracked"}')
    expected_fragment = "elasticache/cluster/my-id"

    # Act / Assert
    with patch("httpx.put", return_value=mock_response):
        with pytest.raises(pytest.skip.Exception) as exc_info:
            session.inject_state("elasticache", "cluster", "my-id", "modifying")

    actual_message = str(exc_info.value)
    assert (
        expected_fragment in actual_message
    ), f"Expected skip message to contain {expected_fragment!r} but got {actual_message!r}"
