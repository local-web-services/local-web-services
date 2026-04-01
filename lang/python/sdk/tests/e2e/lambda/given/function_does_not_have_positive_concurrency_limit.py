"""Given: the "lambda" "function" did not have a positive concurrency limit"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" did not have a positive concurrency limit')
def function_does_not_have_positive_concurrency_limit():
    pytest.skip("Cannot trigger Lambda concurrency-based invocation in lws")
