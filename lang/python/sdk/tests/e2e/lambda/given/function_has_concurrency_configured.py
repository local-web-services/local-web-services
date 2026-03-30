"""Given: the function has concurrency configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the function has concurrency configured")
def function_has_concurrency_configured():
    pytest.skip("Cannot trigger Lambda concurrency-based invocation in lws")
