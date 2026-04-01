"""Given: the "documentdb" "instance" was "CREATING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "instance" was "CREATING"')
def neptune_instance_is_creating(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
