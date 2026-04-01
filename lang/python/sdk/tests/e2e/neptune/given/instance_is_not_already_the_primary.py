"""Given: the "neptune" "instance" was not already the primary"""

from __future__ import annotations

from pytest_bdd import given


@given('the "neptune" "instance" was not already the primary')
def instance_is_not_already_the_primary():
    """No-op: newly created instances are not the primary by default."""
