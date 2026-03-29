"""Given: the instance is "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the instance is "AVAILABLE"')
def instance_is_available_given():
    """No-op: instances are AVAILABLE immediately after creation in lws."""
