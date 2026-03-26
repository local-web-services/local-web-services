"""Given: the replication group is not "MODIFYING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the replication group is not "MODIFYING"')
def rg_is_not_modifying(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
