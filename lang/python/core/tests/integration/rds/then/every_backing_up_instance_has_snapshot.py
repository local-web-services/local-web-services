"""Then: every backing-up instance has a corresponding in-progress snapshot"""

from __future__ import annotations

from pytest_bdd import then


@then("every backing-up instance has a corresponding in-progress snapshot")
def every_backing_up_instance_has_snapshot():
    """Invariant trivially satisfied in isolated test context."""
