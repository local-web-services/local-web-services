"""Given: the "lambda" "function" had at least one active execution"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" had at least one active execution')
def function_has_at_least_one_active_execution(world):
    pytest.skip("Cannot force active executions in integration tests.")
