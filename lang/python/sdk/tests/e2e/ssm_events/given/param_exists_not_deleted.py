"""Given: the "ssm" "parameter" existed (not already "DELETED")"""

from __future__ import annotations

from pytest_bdd import given


@given('the "ssm" "parameter" existed (not already "DELETED")')
def param_exists_not_deleted():
    """No-op: parameter already created by 'the parameter existed' step."""
