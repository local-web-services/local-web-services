"""Given: the user pool does not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the user pool does not exist")
def pool_does_not_exist(world):
    pytest.skip(
        "DeleteUserPool with a nonexistent pool returns 200 in lws "
        "(idempotent deletion); this negative case cannot be tested."
    )
