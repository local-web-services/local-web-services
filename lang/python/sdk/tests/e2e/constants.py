"""Constants and shared helpers."""

from __future__ import annotations

import json

TEST_QUEUE = "e2e-test-q1"

TEST_DLQ = "e2e-test-dlq-1"

TEST_TOPIC = "e2e-test-topic-1"

TEST_BUS = "e2e-test-bus-1"

TEST_RULE = "test-rule-1"

EVENT_PATTERN = json.dumps({"source": ["test.source"]})

TEST_SM = "test-sm-1"

ROLE_ARN = "arn:aws:iam::000000000000:role/test"

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})

TEST_INPUT = '{"key": "value"}'

TEST_TABLE = "e2e-test-tbl-1"

TEST_PK = "pk"

TEST_ITEM_KEY = "e2e-item-key-1"

TEST_BUCKET = "e2e-test-bkt-1"

TEST_KEY = "e2e-test-key-1"

TEST_BODY = b"test-data-content-1"

TEST_PARAM = "/e2e/test/param/1"

TEST_PARAM_VALUE = "e2e-test-value-1"

TEST_SECRET = "e2e-test-secret-1"

TEST_SECRET_VALUE = "e2e-test-secret-value-1"


def _queue_arn(name=TEST_QUEUE):
    return f"arn:aws:sqs:us-east-1:000000000000:{name}"


def _topic_arn(name=TEST_TOPIC):
    return f"arn:aws:sns:us-east-1:000000000000:{name}"


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
