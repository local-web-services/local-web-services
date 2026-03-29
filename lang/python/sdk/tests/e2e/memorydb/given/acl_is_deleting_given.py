"""Given: the "ACL" is "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "ACL" is "DELETING"')
def acl_is_deleting_given():
    pytest.skip("Cannot observe DELETING ACL state in lws")
