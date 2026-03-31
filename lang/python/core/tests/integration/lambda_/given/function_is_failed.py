"""Given: the "lambda" "function" was "FAILED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" was "FAILED"')
def function_is_failed(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
