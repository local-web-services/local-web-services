"""Constants for AWS fake e2e tests."""

from __future__ import annotations

TEST_SERVICE = "dynamodb"
TEST_OPERATION = "ListTables"
TEST_RESPONSE_STATUS = 200
TEST_RESPONSE_BODY = {"TableNames": []}
TEST_HEADER = "X-Amz-Test-Header"
TEST_HEADER_VALUE = "lws-test"
