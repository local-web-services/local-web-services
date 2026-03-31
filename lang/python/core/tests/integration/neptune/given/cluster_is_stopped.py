"""Given: the "documentdb" "cluster" was "STOPPED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "neptune" "cluster" was "STOPPED"')
@given('the "documentdb" "cluster" was "STOPPED"')
def cluster_is_stopped(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
