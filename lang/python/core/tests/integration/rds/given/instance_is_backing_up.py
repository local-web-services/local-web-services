"""Given: the instance is "BACKING_UP" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the instance is "BACKING_UP"')
def instance_is_backing_up(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
