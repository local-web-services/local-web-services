"""When: a database instance deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a database instance deletion completes")
def database_instance_deletion_completes(world):
    pytest.skip(
        "lws DescribeDBInstances with no filter always succeeds "
        "— cannot detect deletion completion."
    )
