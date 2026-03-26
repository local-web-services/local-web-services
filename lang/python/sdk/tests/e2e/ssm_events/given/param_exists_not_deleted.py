"""Given: the parameter "EXISTS" (not already "DELETED")"""

from __future__ import annotations

from pytest_bdd import given


@given('the parameter "EXISTS" (not already "DELETED")')
def param_exists_not_deleted():
    """No-op: parameter already created by 'the parameter exists' step."""
