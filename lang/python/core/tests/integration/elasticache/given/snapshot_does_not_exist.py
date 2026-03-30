"""Given: the snapshot does not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the snapshot does not exist")
def snapshot_does_not_exist(world):
    pytest.skip(
        "lws does not enforce snapshot existence when creating a cache cluster from a snapshot."
    )
