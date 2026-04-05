"""Constants and shared helpers."""

from __future__ import annotations

TEST_TABLE = "e2e-test-tbl-1"

TEST_PK = "pk"

TEST_ITEM_KEY = "e2e-item-key-1"

TEST_ATTR_VAL = "attr-val-1"

TEST_UPDATED_VAL = "attr-val-updated-1"

GSI_TABLE = TEST_TABLE  # GSI is built on the standard test table
GSI_INDEX = "by-status"
GSI_PK = "status"
GSI_PK_VALUE = "active"
