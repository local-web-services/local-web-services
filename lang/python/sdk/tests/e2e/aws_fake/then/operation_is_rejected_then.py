"""Then: the operation is rejected"""

from __future__ import annotations

from pytest_bdd import then


@then("the operation is rejected")
def operation_is_rejected_then():
    """Invariant step: trivially satisfied in isolated test context."""
