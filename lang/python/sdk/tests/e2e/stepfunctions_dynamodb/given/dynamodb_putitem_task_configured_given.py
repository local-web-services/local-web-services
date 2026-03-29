"""Given: a DynamoDB PutItem task has been configured on the state machine"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a DynamoDB PutItem task has been configured on the state machine")
def dynamodb_putitem_task_configured_given():
    pytest.skip("Cannot pre-set a DynamoDB task configuration state for sequence setup")
