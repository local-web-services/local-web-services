"""Given: the function is "FAILED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the function is "FAILED"')
def function_is_failed(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
