"""Unit tests: LwsSession.reset_chaos() calls DELETE /_ldk/chaos/{service}."""

from __future__ import annotations

from unittest.mock import patch


class TestSessionResetChaos:
    def test_reset_chaos_calls_delete_on_correct_url(self):
        # Arrange
        from lws_testing.session import LwsSession

        session = LwsSession()
        session._mgmt_port = 9000
        captured_calls: list = []

        def fake_delete(url, timeout):
            captured_calls.append({"url": url})

        expected_url = "http://127.0.0.1:9000/_ldk/chaos/dynamodb"

        # Act
        with patch("lws_testing._management.chaos.httpx.delete", side_effect=fake_delete):
            session.reset_chaos("dynamodb")

        # Assert
        assert len(captured_calls) == 1
        actual_url = captured_calls[0]["url"]
        assert actual_url == expected_url

    def test_reset_chaos_uses_service_name_in_url(self):
        # Arrange
        from lws_testing.session import LwsSession

        session = LwsSession()
        session._mgmt_port = 9000
        captured_calls: list = []

        def fake_delete(url, timeout):
            captured_calls.append({"url": url})

        expected_url = "http://127.0.0.1:9000/_ldk/chaos/sqs"

        # Act
        with patch("lws_testing._management.chaos.httpx.delete", side_effect=fake_delete):
            session.reset_chaos("sqs")

        # Assert
        actual_url = captured_calls[0]["url"]
        assert actual_url == expected_url
