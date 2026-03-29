"""Given: the Lambda task has failed and the execution has failed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda task has failed and the execution has failed")
def lambda_task_failed_given():
    pytest.skip("Cannot pre-set a failed Lambda invocation state for sequence setup")
