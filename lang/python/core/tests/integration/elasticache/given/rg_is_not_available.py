"""Given: the replication group is not "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the replication group is not "AVAILABLE"')
def rg_is_not_available(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
