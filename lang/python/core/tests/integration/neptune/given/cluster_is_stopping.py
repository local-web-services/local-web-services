"""Given: the cluster is "STOPPING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the cluster is "STOPPING"')
def cluster_is_stopping(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
