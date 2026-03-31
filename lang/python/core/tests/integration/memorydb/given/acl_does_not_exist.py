"""Given: the "memorydb" "ACL" did not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "memorydb" "ACL" did not exist')
def acl_does_not_exist(world):
    pytest.skip("lws does not enforce ACL existence when associating with a cluster.")
