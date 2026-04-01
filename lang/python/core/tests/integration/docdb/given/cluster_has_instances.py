"""Given: the "documentdb" "cluster" has non-deleted instances"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "cluster" has non-deleted instances')
def cluster_has_instances(world):
    pytest.skip("lws does not enforce cluster deletion constraints when instances exist.")
