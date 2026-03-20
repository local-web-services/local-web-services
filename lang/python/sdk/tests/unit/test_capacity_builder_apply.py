"""Unit tests: CapacityBuilder.apply() posts to the management API."""

from __future__ import annotations

from unittest.mock import patch


class TestCapacityBuilderApply:
    def test_apply_posts_to_correct_url(self):
        # Arrange
        from lws_testing._builders.capacity import CapacityBuilder

        captured_calls: list = []

        def fake_post(url, json, timeout):
            captured_calls.append({"url": url, "json": json})

        builder = CapacityBuilder("stepfunctions", 9000)
        builder.exhaust()
        expected_url = "http://127.0.0.1:9000/_ldk/capacity"
        expected_payload = {"stepfunctions": {"slots": 0}}

        # Act
        with patch("lws_testing._builders.capacity.httpx.post", side_effect=fake_post):
            builder.apply()

        # Assert
        assert len(captured_calls) == 1
        actual_url = captured_calls[0]["url"]
        actual_payload = captured_calls[0]["json"]
        assert actual_url == expected_url
        assert actual_payload == expected_payload

    def test_clear_posts_slots_none(self):
        # Arrange
        from lws_testing._builders.capacity import CapacityBuilder

        captured_calls: list = []

        def fake_post(url, json, timeout):
            captured_calls.append({"url": url, "json": json})

        builder = CapacityBuilder("stepfunctions", 9000)
        expected_payload = {"stepfunctions": {"slots": None}}

        # Act
        with patch("lws_testing._builders.capacity.httpx.post", side_effect=fake_post):
            builder.clear()

        # Assert
        assert len(captured_calls) == 1
        actual_payload = captured_calls[0]["json"]
        assert actual_payload == expected_payload
