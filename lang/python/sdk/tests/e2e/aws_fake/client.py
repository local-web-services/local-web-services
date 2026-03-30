"""Test client helpers for AWS fake e2e tests."""

from __future__ import annotations

from .constants import (
    TEST_HEADER,
    TEST_HEADER_VALUE,
    TEST_OPERATION,
    TEST_RESPONSE_BODY,
    TEST_RESPONSE_STATUS,
    TEST_SERVICE,
)


class AwsFakeTestClient:
    """Helper wrapping ``lws_session.client("aws_fake")`` for e2e test setup."""

    def __init__(self, lws_session) -> None:
        self._client = lws_session.client("aws_fake")
        self._dynamodb = lws_session.client("dynamodb")

    def create(self) -> dict:
        """Enable the AWS fake for the test service, silently ignoring if already enabled."""
        try:
            return self._client.create(TEST_SERVICE)
        except ValueError:
            return {}

    def delete(self) -> None:
        """Disable the AWS fake for the test service."""
        self._client.delete(TEST_SERVICE)

    def add_operation(self) -> dict:
        """Add the test operation rule to the AWS fake (no header filter)."""
        try:
            return self._client.add_operation(
                TEST_SERVICE,
                TEST_OPERATION,
                status=TEST_RESPONSE_STATUS,
                body=TEST_RESPONSE_BODY,
            )
        except ValueError:
            return {}

    def add_operation_with_header(self) -> dict:
        """Add the test operation rule with a header filter to the AWS fake."""
        try:
            return self._client.add_operation(
                TEST_SERVICE,
                TEST_OPERATION,
                status=TEST_RESPONSE_STATUS,
                body=TEST_RESPONSE_BODY,
                header_filter={TEST_HEADER: TEST_HEADER_VALUE},
            )
        except ValueError:
            return {}

    def remove_operation(self) -> None:
        """Remove the test operation rule from the AWS fake."""
        self._client.remove_operation(TEST_SERVICE, TEST_OPERATION)

    def make_aws_call(self) -> dict:
        """Make a ListTables call against the (potentially intercepted) DynamoDB service."""
        return self._dynamodb.list_tables()
