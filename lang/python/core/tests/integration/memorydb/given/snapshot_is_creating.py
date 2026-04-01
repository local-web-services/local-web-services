"""Given: the "documentdb" "snapshot" was "CREATING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "snapshot" was "CREATING"')
def snapshot_is_creating(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
