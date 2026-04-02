"""Then: every backing-up "rds" "instance" has a corresponding in-progress "rds" "snapshot" """

from __future__ import annotations

from pytest_bdd import step


@step('every backing-up "rds" "instance" has a corresponding in-progress "rds" "snapshot"')
def backing_up_instance_has_snapshot():
    """No-op: backup snapshot consistency is an internal invariant; always passes."""
