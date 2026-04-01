"""Given: the "memorydb" "user" is already a member of the "memorydb" "ACL" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "memorydb" "user" is already a member of the "memorydb" "ACL"')
def user_is_already_member_of_acl():
    pytest.skip("Cannot configure existing ACL membership in this context")
