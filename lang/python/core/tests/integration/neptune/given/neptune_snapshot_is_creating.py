"""Given: the snapshot is "CREATING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the snapshot is "CREATING"')
def neptune_snapshot_is_creating(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
