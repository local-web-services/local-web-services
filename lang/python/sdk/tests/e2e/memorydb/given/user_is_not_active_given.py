"""Given: the "memorydb" "user" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "memorydb" "user" was not "ACTIVE"')
def user_is_not_active_given():
    pytest.skip("Cannot control user activity state in lws")
