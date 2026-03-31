"""Given: the "documentdb" "instance" was not "CREATING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "instance" was not "CREATING"')
def neptune_instance_is_not_creating(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
