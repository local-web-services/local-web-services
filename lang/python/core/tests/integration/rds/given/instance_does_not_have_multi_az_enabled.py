"""Given: the "rds" "instance" does not have multi-"AZ" enabled"""

from __future__ import annotations

from pytest_bdd import given


@given('the "rds" "instance" does not have multi-"AZ" enabled')
def instance_does_not_have_multi_az_enabled():
    """No-op: fresh instances have no multi-AZ in lws."""
