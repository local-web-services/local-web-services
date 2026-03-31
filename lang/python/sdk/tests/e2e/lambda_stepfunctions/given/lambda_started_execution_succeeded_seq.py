"""Given: the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" starts an execution of an "ACTIVE" state machine and succeeds')
def lambda_started_execution_succeeded_seq():
    pytest.skip("Cannot trigger Lambda Step Functions execution in lws")
