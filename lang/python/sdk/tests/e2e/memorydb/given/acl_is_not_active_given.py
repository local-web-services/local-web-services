"""Given: the "memorydb" "ACL" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "memorydb" "ACL" was not "ACTIVE"')
def acl_is_not_active_given():
    pytest.skip("Cannot control ACL activity state in lws")
