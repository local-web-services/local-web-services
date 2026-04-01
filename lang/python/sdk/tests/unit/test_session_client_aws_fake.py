"""Unit tests: LwsSession.client("aws_fake") returns AwsFakeClient."""

from __future__ import annotations


class TestSessionClientAwsFake:
    def test_client_aws_fake_returns_aws_fake_client(self):
        # Arrange
        from lws_testing._management.aws_fake import AwsFakeClient
        from lws_testing.session import LwsSession

        session = LwsSession()
        session._mgmt_port = 9000

        # Act
        actual_client = session.client("aws_fake")

        # Assert
        assert isinstance(actual_client, AwsFakeClient)

    def test_client_aws_fake_uses_mgmt_port(self):
        # Arrange
        from lws_testing._management.aws_fake import AwsFakeClient
        from lws_testing.session import LwsSession

        session = LwsSession()
        session._mgmt_port = 7777
        expected_port = 7777

        # Act
        actual_client = session.client("aws_fake")

        # Assert
        assert isinstance(actual_client, AwsFakeClient)
        actual_port = actual_client._mgmt_port
        assert actual_port == expected_port
