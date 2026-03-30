"""Given: the function has active executions"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the function has active executions")
def function_has_active_executions():
    pytest.skip("Cannot inject active execution state into Lambda in lws")
