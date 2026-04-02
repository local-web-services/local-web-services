"""Given: the "step functions" "execution"'s state machine has no "sqs" task configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "step functions" "execution"\'s state machine has no "sqs" task configured')
@given('the execution\'s state machine has no "SQS" task configured')
def execution_sm_has_no_sqs_task():
    pytest.skip(
        "lws does not reject start_execution based on state machine definition content"
        " (no SQS task validation)"
    )
