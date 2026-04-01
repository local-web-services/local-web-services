"""Given: the "neptune" "instance" was "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "neptune" "instance" was "AVAILABLE"')
def instance_is_available_given():
    """No-op: instances are AVAILABLE immediately after creation in lws."""
