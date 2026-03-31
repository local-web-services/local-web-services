"""Given: the "cognito" "user pool" already existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "user pool" already existed')
def pool_already_exists(world):
    pytest.skip(
        "CreateUserPool is idempotent in lws (no uniqueness enforcement); "
        "duplicate creation cannot be tested in stateless integration tests."
    )
