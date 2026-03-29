"""Unit tests: LwsSession.client("fake") returns FakeServerClient."""

from __future__ import annotations


class TestSessionClientFake:
    def test_client_fake_returns_fake_server_client(self):
        # Arrange
        from lws_testing._management.fake import FakeServerClient
        from lws_testing.session import LwsSession

        session = LwsSession()
        session._mgmt_port = 9000

        # Act
        actual_client = session.client("fake")

        # Assert
        assert isinstance(actual_client, FakeServerClient)

    def test_client_fake_uses_mgmt_port(self):
        # Arrange
        from lws_testing._management.fake import FakeServerClient
        from lws_testing.session import LwsSession

        session = LwsSession()
        session._mgmt_port = 8888
        expected_port = 8888

        # Act
        actual_client = session.client("fake")

        # Assert
        assert isinstance(actual_client, FakeServerClient)
        actual_port = actual_client._mgmt_port
        assert actual_port == expected_port
