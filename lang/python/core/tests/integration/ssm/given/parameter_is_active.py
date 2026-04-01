"""Given: the "ssm" "parameter" was "active" """

from __future__ import annotations

from pytest_bdd import given


@given('the "ssm" "parameter" was "active"')
def parameter_is_active():
    """No-op: parameters are always active after creation in lws."""
