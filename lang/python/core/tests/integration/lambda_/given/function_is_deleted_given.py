"""Given: the function is "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the function is "DELETED"')
def function_is_deleted_given(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
