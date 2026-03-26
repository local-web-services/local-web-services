"""Given: the instance is "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the instance is "DELETING"')
def instance_is_deleting(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
