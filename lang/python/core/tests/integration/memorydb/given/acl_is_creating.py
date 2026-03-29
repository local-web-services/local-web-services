"""Given: the "ACL" is "CREATING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "ACL" is "CREATING"')
def acl_is_creating(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
