"""Given: the user is "CREATING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the user is "CREATING"')
def user_is_creating_given():
    pytest.skip("Cannot observe CREATING user state in lws")
