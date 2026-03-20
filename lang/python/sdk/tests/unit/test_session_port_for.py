"""Unit tests: LwsSession.port_for() method."""

from __future__ import annotations

import pytest

from lws_testing.session import LwsSession


def test_port_for_returns_correct_port_for_known_service():
    # Arrange
    session = LwsSession()
    expected_service = "dynamodb"
    expected_port = 10001
    session._ports = {"dynamodb": expected_port, "sqs": 10002}

    # Act
    actual_port = session.port_for(expected_service)

    # Assert
    assert actual_port == expected_port, f"Expected {expected_port!r} but got {actual_port!r}"


def test_port_for_raises_for_unknown_service():
    # Arrange
    session = LwsSession()
    session._ports = {"dynamodb": 10001}
    expected_service = "unknown-service"

    # Act / Assert
    with pytest.raises(ValueError, match=expected_service):
        session.port_for(expected_service)


def test_port_for_returns_distinct_ports_for_different_services():
    # Arrange
    session = LwsSession()
    expected_dynamodb_port = 10001
    expected_sqs_port = 10002
    session._ports = {"dynamodb": expected_dynamodb_port, "sqs": expected_sqs_port}

    # Act
    actual_dynamodb_port = session.port_for("dynamodb")
    actual_sqs_port = session.port_for("sqs")

    # Assert
    assert (
        actual_dynamodb_port == expected_dynamodb_port
    ), f"Expected {expected_dynamodb_port!r} but got {actual_dynamodb_port!r}"
    assert (
        actual_sqs_port == expected_sqs_port
    ), f"Expected {expected_sqs_port!r} but got {actual_sqs_port!r}"
    assert (
        actual_dynamodb_port != actual_sqs_port
    ), f"Expected values to differ but both were {actual_dynamodb_port!r}"
