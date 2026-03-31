"""Given: the "lambda" "function" had active execution tracking"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" had active execution tracking')
def function_has_active_execution_tracking():
    pytest.skip("Cannot observe Lambda execution tracking state in lws")
