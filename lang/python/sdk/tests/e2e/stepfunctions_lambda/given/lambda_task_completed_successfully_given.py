"""Given: the Lambda task has completed successfully and the execution has succeeded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda task has completed successfully and the execution has succeeded")
def lambda_task_completed_successfully_given():
    pytest.skip("Cannot pre-set a completed Lambda invocation state for sequence setup")
