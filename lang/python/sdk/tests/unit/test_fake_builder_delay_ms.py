"""Unit tests: FakeRuleBuilder.delay_ms() chaining method."""

from __future__ import annotations

from unittest.mock import patch

from lws_testing._builders.fake import FakeBuilder


def test_delay_ms_stores_value_and_returns_self():
    # Arrange
    fake_builder = FakeBuilder("dynamodb", 9000)
    rule_builder = fake_builder.operation("PutItem")
    expected_delay_ms = 150

    # Act
    actual_result = rule_builder.delay_ms(expected_delay_ms)

    # Assert
    actual_delay_ms = rule_builder._delay_ms
    assert actual_delay_ms == expected_delay_ms, (
        f"Expected {expected_delay_ms!r} but got {actual_delay_ms!r}"
    )
    assert actual_result is rule_builder, "Expected value to be truthy"


def test_delay_ms_included_in_respond_payload():
    # Arrange
    captured_payloads: list = []

    def fake_post(url, json, timeout):
        captured_payloads.append(json)

    with patch("lws_testing._builders.fake.httpx.post", side_effect=fake_post):
        fake_builder = FakeBuilder("dynamodb", 9000)
        expected_delay_ms = 250

        # Act
        fake_builder.operation("PutItem").delay_ms(expected_delay_ms).respond(status=200)

    # Assert
    assert len(captured_payloads) == 1, f"Expected {1!r} but got {len(captured_payloads)!r}"
    actual_delay_ms = captured_payloads[0]["dynamodb"]["rules"][0]["response"]["delay_ms"]
    assert actual_delay_ms == expected_delay_ms, (
        f"Expected {expected_delay_ms!r} but got {actual_delay_ms!r}"
    )


def test_delay_ms_defaults_to_zero_when_not_called():
    # Arrange
    fake_builder = FakeBuilder("dynamodb", 9000)
    rule_builder = fake_builder.operation("PutItem")
    expected_delay_ms = 0

    # Act / Assert
    actual_delay_ms = rule_builder._delay_ms
    assert actual_delay_ms == expected_delay_ms, (
        f"Expected {expected_delay_ms!r} but got {actual_delay_ms!r}"
    )


def test_respond_delay_ms_param_overrides_chained_delay_ms():
    # Arrange
    captured_payloads: list = []

    def fake_post(url, json, timeout):
        captured_payloads.append(json)

    with patch("lws_testing._builders.fake.httpx.post", side_effect=fake_post):
        fake_builder = FakeBuilder("dynamodb", 9000)
        expected_delay_ms = 300

        # Act — both chained and param provided; param wins when non-zero
        fake_builder.operation("PutItem").delay_ms(100).respond(
            status=200, delay_ms=expected_delay_ms
        )

    # Assert
    actual_delay_ms = captured_payloads[0]["dynamodb"]["rules"][0]["response"]["delay_ms"]
    assert actual_delay_ms == expected_delay_ms, (
        f"Expected {expected_delay_ms!r} but got {actual_delay_ms!r}"
    )
