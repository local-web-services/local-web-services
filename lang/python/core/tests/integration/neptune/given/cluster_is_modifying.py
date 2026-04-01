"""Given: the "documentdb" "cluster" was "MODIFYING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "cluster" was "MODIFYING"')
def cluster_is_modifying(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
