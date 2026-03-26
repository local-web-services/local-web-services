"""Given: the "ACL" is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "ACL" is not "ACTIVE"')
def acl_is_not_active(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
