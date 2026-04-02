"""When: the "lambda" task fails and the "step functions" "execution" fails"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the "lambda" task fails and the "step functions" "execution" fails')
def lambda_task_fails(world):
    pytest.skip("Cannot trigger Lambda invocation from StepFunctions in lws")
