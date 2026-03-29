"""Given: the cluster is "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the cluster is "DELETING"')
def cluster_is_deleting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
