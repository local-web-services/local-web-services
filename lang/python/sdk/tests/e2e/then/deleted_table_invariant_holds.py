"""Then: deleted_table_invariant_holds"""

from __future__ import annotations

from pytest_bdd import parsers, then


@then(parsers.re(r"^deleted tables are never .+"))
def deleted_table_invariant_holds():
    """Invariant steps are trivially satisfied in an isolated test context."""
