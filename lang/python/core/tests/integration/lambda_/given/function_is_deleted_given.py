"""Given: the "lambda" "function" will be "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" will be "DELETED"')
def function_is_deleted_given(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
