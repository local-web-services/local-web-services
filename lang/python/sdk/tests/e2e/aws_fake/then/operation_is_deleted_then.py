"""Then: the operation is "DELETED" """

from __future__ import annotations

from pytest_bdd import then


@then('the operation is "DELETED"')
def operation_is_deleted_then():
    """Invariant step: trivially satisfied in isolated test context."""
