"""When: the Lambda task completes successfully and the execution succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda task completes successfully and the execution succeeds")
def lambda_task_succeeds(world):
    pytest.skip("Cannot trigger Lambda invocation from StepFunctions in lws")
