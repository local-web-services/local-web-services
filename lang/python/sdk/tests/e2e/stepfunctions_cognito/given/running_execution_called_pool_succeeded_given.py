"""Given: a running execution has called an "ACTIVE" Cognito user pool and the task succeeded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a running execution has called an "ACTIVE" Cognito user pool and the task succeeded')
def running_execution_called_pool_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution Cognito task state for sequence setup")
