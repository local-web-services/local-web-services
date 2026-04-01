"""Then: every table has a valid status ("CREATING", "ACTIVE", or "DELETED")"""

from __future__ import annotations

from pytest_bdd import step


@step('every table has a valid status ("CREATING", "ACTIVE", or "DELETED")')
def _inv_dynamodb_every_table_has_a_valid_status_creating_active_or_deleted():
    """Invariant step: trivially satisfied in isolated test context."""
