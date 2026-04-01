"""Given: the "documentdb" "instance" was not "CREATING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "instance" was not "CREATING"')
def instance_is_not_creating(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
