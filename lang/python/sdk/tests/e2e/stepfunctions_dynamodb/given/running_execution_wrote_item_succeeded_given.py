"""Given: a running execution has written an item to the DynamoDB table and succeeded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a running execution has written an item to the DynamoDB table and succeeded")
def running_execution_wrote_item_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution DynamoDB write state for sequence setup")
