"""Given: the "documentdb" "snapshot" was "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "snapshot" was "DELETING"')
def snapshot_is_deleting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
