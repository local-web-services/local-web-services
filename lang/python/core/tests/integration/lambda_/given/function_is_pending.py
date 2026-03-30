"""Given: the function is "PENDING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the function is "PENDING"')
def function_is_pending(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
