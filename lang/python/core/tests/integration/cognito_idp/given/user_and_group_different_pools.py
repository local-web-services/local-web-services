"""Given: the user and group belong to different pools"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the user and group belong to different pools")
def user_and_group_different_pools(world):
    pytest.skip("Multi-pool routing is not supported in stateless integration tests.")
