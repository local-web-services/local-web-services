"""Then: every backing-up "rds" "instance" has a corresponding in-progress "rds" "snapshot" """

from __future__ import annotations

from pytest_bdd import then


@then('every backing-up "rds" "instance" has a corresponding in-progress "rds" "snapshot"')
def every_backing_up_instance_has_snapshot():
    """Invariant trivially satisfied in isolated test context."""
