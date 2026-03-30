"""Given: the Lambda function has started an execution of an "ACTIVE" state machine and succeeded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the Lambda function has started an execution of an "ACTIVE" state machine and succeeded')
def lambda_started_execution_succeeded_seq():
    pytest.skip("Cannot trigger Lambda Step Functions execution in lws")
