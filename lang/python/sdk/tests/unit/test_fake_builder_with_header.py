"""Unit tests: FakeRuleBuilder.with_header() chaining method."""

from __future__ import annotations

from unittest.mock import patch

from lws_testing._builders.fake import FakeBuilder


def test_with_header_stores_value_and_returns_self():
    # Arrange
    fake_builder = FakeBuilder("dynamodb", 9000)
    rule_builder = fake_builder.operation("PutItem")
    expected_name = "X-Amz-Target"
    expected_value = "DynamoDB_20120810.PutItem"

    # Act
    actual_result = rule_builder.with_header(expected_name, expected_value)

    # Assert
    actual_headers = rule_builder._match_headers
    assert actual_headers[expected_name] == expected_value
    assert actual_result is rule_builder


def test_with_header_included_in_respond_payload():
    # Arrange
    captured_payloads: list = []

    def fake_post(url, json, timeout):
        captured_payloads.append(json)

    with patch("lws_testing._builders.fake.httpx.post", side_effect=fake_post):
        fake_builder = FakeBuilder("dynamodb", 9000)
        expected_name = "X-Amz-Target"
        expected_value = "DynamoDB_20120810.PutItem"

        # Act
        fake_builder.operation("PutItem").with_header(
            expected_name, expected_value
        ).respond(status=200)

    # Assert
    assert len(captured_payloads) == 1
    actual_headers = captured_payloads[0]["dynamodb"]["rules"][0]["match_headers"]
    assert actual_headers[expected_name] == expected_value


def test_with_header_multiple_headers_all_included():
    # Arrange
    captured_payloads: list = []

    def fake_post(url, json, timeout):
        captured_payloads.append(json)

    with patch("lws_testing._builders.fake.httpx.post", side_effect=fake_post):
        fake_builder = FakeBuilder("sqs", 9001)
        expected_headers = {"X-Header-One": "value1", "X-Header-Two": "value2"}

        # Act
        rule_builder = fake_builder.operation("SendMessage")
        for name, value in expected_headers.items():
            rule_builder.with_header(name, value)
        rule_builder.respond(status=200)

    # Assert
    actual_headers = captured_payloads[0]["sqs"]["rules"][0]["match_headers"]
    assert actual_headers == expected_headers


def test_with_header_empty_by_default():
    # Arrange
    fake_builder = FakeBuilder("s3", 9002)
    rule_builder = fake_builder.operation("PutObject")
    expected_headers: dict = {}

    # Act / Assert
    actual_headers = rule_builder._match_headers
    assert actual_headers == expected_headers
