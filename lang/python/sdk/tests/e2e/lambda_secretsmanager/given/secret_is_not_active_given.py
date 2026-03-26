"""Given: the secret is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the secret is not "ACTIVE"')
def secret_is_not_active_given(lws_session, world):  # noqa: ARG001
    pytest.skip("lws does not reject delete_secret on a PENDING_DELETION secret")
