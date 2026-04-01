"""When: the Lambda task fails and the execution fails"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda task fails and the execution fails")
def lambda_task_fails(world):
    pytest.skip("Cannot trigger Lambda invocation from StepFunctions in lws")
