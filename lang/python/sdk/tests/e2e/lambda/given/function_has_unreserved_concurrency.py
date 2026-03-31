"""Given: the "lambda" "function" had unreserved concurrency"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" had unreserved concurrency')
def function_has_unreserved_concurrency():
    pytest.skip("Cannot trigger Lambda concurrency-based invocation in lws")
