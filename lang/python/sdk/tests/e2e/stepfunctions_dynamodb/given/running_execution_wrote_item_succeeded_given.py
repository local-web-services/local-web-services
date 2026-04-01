"""Given: a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds'
)
def running_execution_wrote_item_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution DynamoDB write state for sequence setup")
