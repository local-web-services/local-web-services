"""Given: the "secrets manager" "secret" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "secrets manager" "secret" was not "ACTIVE"')
def secret_is_not_active_given(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
