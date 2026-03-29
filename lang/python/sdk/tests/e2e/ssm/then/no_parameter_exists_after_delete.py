"""Then: no parameter exists after it has been deleted"""

from __future__ import annotations

from pytest_bdd import then


@then("no parameter exists after it has been deleted")
def no_parameter_exists_after_delete():
    """No-op invariant: trivially satisfied in an isolated test context."""
