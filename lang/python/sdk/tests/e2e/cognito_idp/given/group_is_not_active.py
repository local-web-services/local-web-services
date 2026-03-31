"""Given: the "cognito" "group" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "group" was not "ACTIVE"')
def group_is_not_active():
    """No-op: groups are always active in lws; this represents a deleted group."""
    pytest.skip("Cannot represent a non-ACTIVE group in lws without deleting it first")
