"""Given: the "documentdb" "instance" was "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "documentdb" "instance" was "AVAILABLE"')
def instance_is_available():
    """No-op: instances are AVAILABLE immediately after creation in lws."""
