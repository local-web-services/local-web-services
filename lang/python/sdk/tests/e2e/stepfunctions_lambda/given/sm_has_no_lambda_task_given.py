"""Given: the "step functions" "state machine" has no "lambda" task configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "step functions" "state machine" has no "lambda" task configured')
def sm_has_no_lambda_task_given():
    pytest.skip(
        "lws does not reject start_execution when the state machine has no Lambda task configured"
    )
