"""Given: the "ACL" is "MODIFYING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "ACL" is "MODIFYING"')
def acl_is_modifying(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
