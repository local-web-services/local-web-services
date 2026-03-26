"""Given: the "ACL" is "CREATING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "ACL" is "CREATING"')
def acl_is_creating_given():
    pytest.skip("Cannot observe CREATING ACL state in lws")
