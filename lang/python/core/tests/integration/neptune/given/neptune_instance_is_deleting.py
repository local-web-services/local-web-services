"""Given: the instance is "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the instance is "DELETING"')
def neptune_instance_is_deleting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
