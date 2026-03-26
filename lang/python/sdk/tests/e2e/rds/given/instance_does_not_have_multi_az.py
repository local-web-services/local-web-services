"""Given: the instance does not have multi-"AZ" enabled"""

from __future__ import annotations

from pytest_bdd import given


@given('the instance does not have multi-"AZ" enabled')
def instance_does_not_have_multi_az():
    """No-op: multi-AZ is not enabled by default."""
