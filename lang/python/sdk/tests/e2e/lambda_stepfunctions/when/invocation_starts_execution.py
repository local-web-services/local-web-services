"""When: the Lambda function starts an execution of an "ACTIVE" state machine and succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the Lambda function starts an execution of an "ACTIVE" state machine and succeeds')
def invocation_starts_execution(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
