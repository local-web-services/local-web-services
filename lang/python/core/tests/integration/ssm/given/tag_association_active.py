"""Given: the "ssm" "parameter" tag association was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "ssm" "parameter" tag association was "ACTIVE"')
def tag_association_active():
    """No-op: tag associations are always active after creation."""
