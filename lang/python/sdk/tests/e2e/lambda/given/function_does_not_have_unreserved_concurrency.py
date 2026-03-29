"""Given: the function does not have unreserved concurrency"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the function does not have unreserved concurrency")
def function_does_not_have_unreserved_concurrency():
    pytest.skip("Cannot trigger Lambda concurrency-based invocation in lws")
