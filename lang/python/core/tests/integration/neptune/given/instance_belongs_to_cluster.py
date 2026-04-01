"""Given: the "documentdb" "instance" belongs to this documentdb cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "instance" belongs to this documentdb cluster')
def instance_belongs_to_cluster(world):
    pytest.skip("Cluster membership tracking is not available in stateless integration tests.")
