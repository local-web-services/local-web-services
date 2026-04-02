"""Given: the "lambda" "function" active executions were below the concurrency limit"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" active executions were below the concurrency limit')
def active_executions_below_concurrency_limit():
    pytest.skip("Cannot trigger Lambda concurrency-based invocation in lws")
