"""Given: a running "step functions" "execution" updates an item in the "dynamodb" "table" and succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a running "step functions" "execution" updates an item in the "dynamodb" "table" and succeeds'
)
def running_execution_updated_item_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution DynamoDB update state for sequence setup")
