"""Given: the "documentdb" "cluster" was not "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "cluster" was not "AVAILABLE"')
def cluster_is_not_available(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
