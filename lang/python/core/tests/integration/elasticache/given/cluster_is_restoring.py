"""Given: the "documentdb" "cluster" was "RESTORING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "cluster" was "RESTORING"')
def cluster_is_restoring(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
