"""Given: the "memorydb" "ACL" was "MODIFYING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "memorydb" "ACL" was "MODIFYING"')
def acl_is_modifying(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
