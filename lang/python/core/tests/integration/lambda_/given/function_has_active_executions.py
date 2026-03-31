"""Given: the "lambda" "function" had active executions"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" had active executions')
def function_has_active_executions(world):
    pytest.skip("Cannot force active executions in integration tests.")
