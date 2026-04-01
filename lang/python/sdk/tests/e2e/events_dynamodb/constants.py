"""Constants and shared helpers."""

from __future__ import annotations

import json

TEST_BUS = "e2e-test-bus-1"

TEST_RULE = "test-rule-1"

TEST_TABLE = "e2e-test-table-1"

TEST_PK = "id"

TEST_ITEM_KEY = "e2e-item-key-1"

EVENT_PATTERN = json.dumps({"source": ["test.source"]})

ROLE_ARN = "arn:aws:iam::000000000000:role/test"
