"""Then: the state machine will invoke the function when it reaches the task state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the state machine will invoke the function when it reaches the task state")
def sm_will_invoke_function_then():
    pytest.skip("Cannot trigger Lambda invocation from StepFunctions in lws")
