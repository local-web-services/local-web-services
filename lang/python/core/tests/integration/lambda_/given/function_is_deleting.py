"""Given: the "lambda" "function" was "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" was "DELETING"')
def function_is_deleting(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
