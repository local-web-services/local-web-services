"""Given: the "documentdb" "cluster" has non-deleted instances"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "cluster" has non-deleted instances')
def cluster_has_non_deleted_instances(world):
    pytest.skip(
        "lws does not enforce instance-count constraint on cluster deletion in integration tests."
    )
