"""Given: the function has a positive concurrency limit"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the function has a positive concurrency limit")
def function_has_positive_concurrency_limit():
    pytest.skip("Cannot trigger Lambda concurrency-based invocation in lws")
