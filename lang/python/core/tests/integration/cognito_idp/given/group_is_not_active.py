"""Given: the "cognito" "group" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "group" was not "ACTIVE"')
def group_is_not_active(world):
    pytest.skip(
        "Lifecycle-dependent state (non-ACTIVE group) is not supported "
        "in stateless integration tests."
    )
