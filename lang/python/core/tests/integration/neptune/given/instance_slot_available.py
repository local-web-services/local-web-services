"""Given: the "documentdb" "instance" slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given('the "neptune" "instance" slot is available')
@given('the "documentdb" "instance" slot is available')
def instance_slot_available():
    """No-op: instance slots are always available in lws."""
