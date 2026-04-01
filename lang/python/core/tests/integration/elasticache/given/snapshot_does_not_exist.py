"""Given: the "documentdb" "snapshot" did not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticache" "snapshot" did not exist')
@given('the "documentdb" "snapshot" did not exist')
def snapshot_does_not_exist(world):
    pytest.skip(
        "lws does not enforce snapshot existence when creating a cache cluster from a snapshot."
    )
