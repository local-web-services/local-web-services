"""Given: the "elasticache" "replication group" was "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticache" "replication group" was "DELETING"')
def rg_is_deleting(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
