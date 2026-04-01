"""Constants and shared helpers."""

from __future__ import annotations

TEST_FUNC = "e2e-test-func-1"

ROLE_ARN = "arn:aws:iam::000000000000:role/test"

TEST_TAG_KEY = "e2e-test-tag-key-1"

TEST_TAG_VALUE = "e2e-test-tag-value-1"

TEST_STATEMENT_ID = "e2e-test-stmt-1"


def _func_arn(name=TEST_FUNC):
    return f"arn:aws:lambda:us-east-1:000000000000:function:{name}"
