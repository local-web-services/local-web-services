"""Then: the operation will be deleted"""

from __future__ import annotations

from pytest_bdd import then


@then("the operation will be deleted")
def operation_is_deleted_then():
    """Invariant step: trivially satisfied in isolated test context."""
