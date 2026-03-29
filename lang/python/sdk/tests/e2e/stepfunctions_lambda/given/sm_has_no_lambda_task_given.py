"""Given: the state machine has no Lambda task configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the state machine has no Lambda task configured")
def sm_has_no_lambda_task_given():
    pytest.skip(
        "lws does not reject start_execution when the state machine has no Lambda task configured"
    )
