"""Given: a "dynamodb" "UpdateItem" task is configured on the "step functions" "state machine" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "dynamodb" "UpdateItem" task is configured on the "step functions" "state machine"')
def dynamodb_updateitem_task_configured_given():
    pytest.skip("Cannot pre-set a DynamoDB UpdateItem task configuration state for sequence setup")
