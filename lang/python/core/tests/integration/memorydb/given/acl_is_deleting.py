"""Given: the "memorydb" "ACL" was "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "memorydb" "ACL" was "DELETING"')
def acl_is_deleting(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
