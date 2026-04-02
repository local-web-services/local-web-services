"""Given: the "lambda" task completes successfully and the "step functions" "execution" succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" task completes successfully and the "step functions" "execution" succeeds')
def lambda_task_completed_successfully_given():
    pytest.skip("Cannot pre-set a completed Lambda invocation state for sequence setup")
