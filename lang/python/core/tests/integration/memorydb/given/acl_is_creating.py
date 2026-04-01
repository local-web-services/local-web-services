"""Given: the "memorydb" "ACL" was "CREATING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "memorydb" "ACL" was "CREATING"')
def acl_is_creating(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
