"""Given: the "lambda" "function" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" was not "ACTIVE"')
def function_is_not_active(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
