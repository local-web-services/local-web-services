"""Given: the "lambda" task fails and the "step functions" "execution" fails"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" task fails and the "step functions" "execution" fails')
def lambda_task_failed_given():
    pytest.skip("Cannot pre-set a failed Lambda invocation state for sequence setup")
