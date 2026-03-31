"""Given: the "lambda" "function" had no active executions"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" had no active executions')
def function_has_no_active_executions_tracking():
    pytest.skip("Cannot observe Lambda execution tracking state in lws")
