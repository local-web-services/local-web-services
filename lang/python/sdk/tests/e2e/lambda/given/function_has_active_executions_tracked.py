"""Given: the function has active executions tracked"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the function has active executions tracked")
def function_has_active_executions_tracked():
    pytest.skip("Cannot trigger Lambda concurrency-based invocation in lws")
