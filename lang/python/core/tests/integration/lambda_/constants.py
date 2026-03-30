"""Constants and shared helpers."""

from __future__ import annotations

INT_FUNCTION_NAME = "int-lambda-fn-1"

INT_FUNCTION_ARN = f"arn:aws:lambda:us-east-1:123456789012:function:{INT_FUNCTION_NAME}"

INT_ESM_SOURCE_ARN = "arn:aws:sqs:us-east-1:123456789012:int-test-queue-1"

INT_ROLE_ARN = "arn:aws:iam::123456789012:role/int-test-role-1"

INT_TAG_KEY = "int-lambda-tag-key-1"

INT_TAG_VALUE = "int-lambda-tag-val-1"

INT_STATEMENT_ID = "int-lambda-stmt-1"

INT_PRINCIPAL = "events.amazonaws.com"
