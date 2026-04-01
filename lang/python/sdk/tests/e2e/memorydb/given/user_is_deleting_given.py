"""Given: the "memorydb" "user" was "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "memorydb" "user" was "DELETING"')
def user_is_deleting_given():
    pytest.skip("Cannot observe DELETING user state in lws")
