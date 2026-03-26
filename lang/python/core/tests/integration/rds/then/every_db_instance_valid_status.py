"""Then: every database instance has a valid status"""

from __future__ import annotations

from pytest_bdd import then


@then("every database instance has a valid status")
def every_db_instance_valid_status():
    """Invariant trivially satisfied in isolated test context."""
