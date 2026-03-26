"""Given: the function does not have active execution tracking"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the function does not have active execution tracking")
def function_does_not_have_active_execution_tracking():
    pytest.skip("Cannot observe Lambda execution tracking state in lws")
