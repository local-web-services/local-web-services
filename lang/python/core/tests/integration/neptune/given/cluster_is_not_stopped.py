"""Given: the "documentdb" "cluster" was not "STOPPED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "cluster" was not "STOPPED"')
def cluster_is_not_stopped(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
