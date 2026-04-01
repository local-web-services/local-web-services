"""Given: the "cognito" "user" and group belonged to different pools"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "user" and group belonged to different pools')
def user_and_group_belong_to_different_pools():
    pytest.skip("Cannot represent user and group in different pools for the same operation in lws")
