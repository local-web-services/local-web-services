"""Unit tests: LwsSession.set_chaos() calls PUT /_ldk/chaos/{service}."""

from __future__ import annotations

from unittest.mock import patch


class TestSessionSetChaos:
    def test_set_chaos_calls_put_on_correct_url(self):
        # Arrange
        from lws_testing.session import LwsSession

        session = LwsSession()
        session._mgmt_port = 9000
        captured_calls: list = []

        def fake_put(url, json, timeout):
            captured_calls.append({"url": url, "json": json})

        expected_url = "http://127.0.0.1:9000/_ldk/chaos/dynamodb"

        # Act
        with patch("lws_testing._management.chaos.httpx.put", side_effect=fake_put):
            session.set_chaos("dynamodb", error_rate=0.5)

        # Assert
        assert len(captured_calls) == 1
        actual_url = captured_calls[0]["url"]
        assert actual_url == expected_url

    def test_set_chaos_sends_error_rate(self):
        # Arrange
        from lws_testing.session import LwsSession

        session = LwsSession()
        session._mgmt_port = 9000
        captured_calls: list = []

        def fake_put(url, json, timeout):
            captured_calls.append({"url": url, "json": json})

        expected_error_rate = 0.75

        # Act
        with patch("lws_testing._management.chaos.httpx.put", side_effect=fake_put):
            session.set_chaos("dynamodb", error_rate=0.75)

        # Assert
        actual_error_rate = captured_calls[0]["json"]["error_rate"]
        assert actual_error_rate == expected_error_rate

    def test_set_chaos_sends_latency(self):
        # Arrange
        from lws_testing.session import LwsSession

        session = LwsSession()
        session._mgmt_port = 9000
        captured_calls: list = []

        def fake_put(url, json, timeout):
            captured_calls.append({"url": url, "json": json})

        expected_latency_min = 200
        expected_latency_max = 200

        # Act
        with patch("lws_testing._management.chaos.httpx.put", side_effect=fake_put):
            session.set_chaos("dynamodb", latency_ms=200)

        # Assert
        actual_latency_min = captured_calls[0]["json"]["latency_min_ms"]
        actual_latency_max = captured_calls[0]["json"]["latency_max_ms"]
        assert actual_latency_min == expected_latency_min
        assert actual_latency_max == expected_latency_max
