"""Unit tests: LwsSession.get_chaos_status() calls GET /_ldk/chaos/{service}."""

from __future__ import annotations

from unittest.mock import MagicMock, patch


class TestSessionGetChaosStatus:
    def test_get_chaos_status_calls_get_on_correct_url(self):
        # Arrange
        from lws_testing.session import LwsSession

        session = LwsSession()
        session._mgmt_port = 9000
        captured_calls: list = []
        mock_resp = MagicMock()
        mock_resp.json.return_value = {"enabled": False, "error_rate": 0.0}

        def fake_get(url, timeout):
            captured_calls.append({"url": url})
            return mock_resp

        expected_url = "http://127.0.0.1:9000/_ldk/chaos/dynamodb"

        # Act
        with patch("lws_testing._management.chaos.httpx.get", side_effect=fake_get):
            session.get_chaos_status("dynamodb")

        # Assert
        assert len(captured_calls) == 1
        actual_url = captured_calls[0]["url"]
        assert actual_url == expected_url

    def test_get_chaos_status_returns_response_json(self):
        # Arrange
        from lws_testing.session import LwsSession

        session = LwsSession()
        session._mgmt_port = 9000
        mock_resp = MagicMock()
        mock_resp.json.return_value = {"enabled": True, "error_rate": 0.5}

        def fake_get(url, timeout):
            return mock_resp

        expected_result = {"enabled": True, "error_rate": 0.5}

        # Act
        with patch("lws_testing._management.chaos.httpx.get", side_effect=fake_get):
            actual_result = session.get_chaos_status("dynamodb")

        # Assert
        assert actual_result == expected_result
