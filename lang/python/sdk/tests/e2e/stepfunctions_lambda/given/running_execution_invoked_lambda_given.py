"""Given: a running "step functions" "execution" reaches the Lambda task state and invokes the function"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a running "step functions" "execution" reaches the Lambda task state and invokes the function'
)
def running_execution_invoked_lambda_given():
    pytest.skip("Cannot pre-set a Lambda invocation state for sequence setup")
