"""Given: the object is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the object is not "ACTIVE"')
def object_is_not_active_given(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
