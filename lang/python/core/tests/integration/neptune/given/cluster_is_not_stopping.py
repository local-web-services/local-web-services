"""Given: the "neptune" "cluster" was not "STOPPING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "neptune" "cluster" was not "STOPPING"')
def cluster_is_not_stopping(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
