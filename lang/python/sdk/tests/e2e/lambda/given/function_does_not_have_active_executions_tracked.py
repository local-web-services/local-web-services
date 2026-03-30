"""Given: the function does not have active executions tracked"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the function does not have active executions tracked")
def function_does_not_have_active_executions_tracked():
    pytest.skip("Cannot trigger Lambda concurrency-based invocation in lws")
