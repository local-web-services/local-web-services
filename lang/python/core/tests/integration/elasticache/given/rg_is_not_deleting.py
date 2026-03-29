"""Given: the replication group is not "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the replication group is not "DELETING"')
def rg_is_not_deleting(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
