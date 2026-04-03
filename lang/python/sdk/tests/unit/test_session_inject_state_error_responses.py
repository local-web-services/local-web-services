"""Unit tests: LwsSession.inject_state() raises RuntimeError on non-404 error responses."""

from __future__ import annotations

from unittest.mock import MagicMock, patch

import pytest

from lws_testing.session import LwsSession


def test_inject_state_raises_runtime_error_on_409():
    # Arrange
    session = LwsSession()
    session._mgmt_port = 19000
    mock_response = MagicMock(
        status_code=409,
        text='{"error": "cluster \'my-id\' is not in a valid predecessor state"}',
    )

    # Act / Assert
    with patch("httpx.put", return_value=mock_response):
        with pytest.raises(RuntimeError):
            session.inject_state("elasticache", "cluster", "my-id", "available")


def test_inject_state_raises_runtime_error_on_400():
    # Arrange
    session = LwsSession()
    session._mgmt_port = 19000
    mock_response = MagicMock(status_code=400, text='{"error": "state is required"}')

    # Act / Assert
    with patch("httpx.put", return_value=mock_response):
        with pytest.raises(RuntimeError):
            session.inject_state("elasticache", "cluster", "my-id", "")
