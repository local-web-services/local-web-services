"""Given: the instance is "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the instance is "AVAILABLE"')
def neptune_instance_is_available():
    """No-op: instances are AVAILABLE immediately after creation in lws."""
