"""Then: the "step functions" "state machine" will invoke the "lambda" "function" when it reaches the task state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'the "step functions" "state machine" will invoke the "lambda" "function" when it reaches the task state'
)
def sm_will_invoke_function_then():
    pytest.skip("Cannot trigger Lambda invocation from StepFunctions in lws")
