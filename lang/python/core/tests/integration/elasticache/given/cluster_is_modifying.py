"""Given: the cluster is "MODIFYING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the cluster is "MODIFYING"')
def cluster_is_modifying(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
