"""When: a replication group deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a replication group deletion completes")
def replication_group_deletion_completes(world):
    pytest.skip(
        "lws DescribeReplicationGroups with no filter always succeeds "
        "— cannot detect deletion completion."
    )
