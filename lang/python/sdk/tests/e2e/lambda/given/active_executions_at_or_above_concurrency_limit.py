"""Given: the active executions are at or above the concurrency limit"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the active executions are at or above the concurrency limit")
def active_executions_at_or_above_concurrency_limit():
    pytest.skip("Cannot trigger Lambda concurrency-based invocation in lws")
