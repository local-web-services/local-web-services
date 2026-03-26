"""Given: the instance is not "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the instance is not "DELETING"')
def neptune_instance_is_not_deleting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
