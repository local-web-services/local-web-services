"""Given: the "documentdb" "snapshot" was not "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "snapshot" was not "AVAILABLE"')
def snapshot_is_not_available(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
