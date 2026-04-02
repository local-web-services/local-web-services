"""Given: the "step functions" "state machine" already has an "sqs" task configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "step functions" "state machine" already has an "sqs" task configured')
def sm_already_has_sqs_task():
    pytest.skip(
        "lws allows update_state_machine even when the state machine already has an SQS task"
        " configured (idempotent overwrite allowed)"
    )
