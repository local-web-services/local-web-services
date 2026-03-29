"""
Given: a running execution has attempted to get an item that does not exist and the execution
failed
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    "a running execution has attempted to get an item that does not exist and the execution failed"
)
def running_execution_get_item_failed_given():
    pytest.skip("Cannot pre-set a failed execution DynamoDB get state for sequence setup")
