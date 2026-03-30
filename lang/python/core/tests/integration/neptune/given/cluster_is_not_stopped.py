"""Given: the cluster is not "STOPPED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the cluster is not "STOPPED"')
def cluster_is_not_stopped(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
