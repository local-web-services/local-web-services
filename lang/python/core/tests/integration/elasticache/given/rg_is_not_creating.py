"""Given: the replication group is not "CREATING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the replication group is not "CREATING"')
def rg_is_not_creating(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
