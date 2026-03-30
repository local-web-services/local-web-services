"""Given: the user is a member of the "ACL" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the user is a member of the "ACL"')
def user_is_member_of_acl():
    pytest.skip("Cannot configure ACL membership in this context")
