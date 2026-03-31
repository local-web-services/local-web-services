"""Given: the "memorydb" "user" was a member of the "memorydb" "ACL" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "memorydb" "user" was a member of the "memorydb" "ACL"')
def user_is_member_of_acl():
    pytest.skip("Cannot configure ACL membership in this context")
