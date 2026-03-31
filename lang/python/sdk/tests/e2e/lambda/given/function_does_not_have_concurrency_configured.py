"""Given: the "lambda" "function" did not have concurrency configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" did not have concurrency configured')
def function_does_not_have_concurrency_configured():
    pytest.skip("Cannot trigger Lambda concurrency-based invocation in lws")
