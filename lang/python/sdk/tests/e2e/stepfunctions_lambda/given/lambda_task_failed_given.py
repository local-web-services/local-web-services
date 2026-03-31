"""Given: the Lambda task fails and the execution fails"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda task fails and the execution fails")
def lambda_task_failed_given():
    pytest.skip("Cannot pre-set a failed Lambda invocation state for sequence setup")
