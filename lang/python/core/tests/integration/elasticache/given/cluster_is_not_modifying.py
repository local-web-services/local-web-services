"""Given: the cluster is not "MODIFYING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the cluster is not "MODIFYING"')
def cluster_is_not_modifying(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
