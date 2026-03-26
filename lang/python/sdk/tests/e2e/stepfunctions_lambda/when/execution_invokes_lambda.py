"""When: a running execution reaches the Lambda task state and invokes the function"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a running execution reaches the Lambda task state and invokes the function")
def execution_invokes_lambda(world):
    pytest.skip("Cannot trigger Lambda invocation from StepFunctions in lws")
