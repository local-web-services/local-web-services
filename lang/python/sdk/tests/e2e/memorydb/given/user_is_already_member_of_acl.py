"""Given: the user is already a member of the "ACL" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the user is already a member of the "ACL"')
def user_is_already_member_of_acl():
    pytest.skip("Cannot configure existing ACL membership in this context")
