"""When: the "lambda" task completes successfully and the "step functions" "execution" succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the "lambda" task completes successfully and the "step functions" "execution" succeeds')
def lambda_task_succeeds(world):
    pytest.skip("Cannot trigger Lambda invocation from StepFunctions in lws")
