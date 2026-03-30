"""Given: the state machine already has a DynamoDB task configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the state machine already has a DynamoDB task configured")
def sm_already_has_dynamodb_task():
    pytest.skip(
        "lws allows update_state_machine even when the state machine already has a DynamoDB task"
        " configured (idempotent overwrite allowed)"
    )
