"""Given: the "lambda" "function" did not have unreserved concurrency"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" did not have unreserved concurrency')
def function_does_not_have_unreserved_concurrency(world):
    pytest.skip("Cannot exhaust unreserved concurrency in integration tests.")
