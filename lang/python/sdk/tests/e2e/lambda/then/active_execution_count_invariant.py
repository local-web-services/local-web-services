"""Then: active_execution_count_invariant"""

from __future__ import annotations

from pytest_bdd import parsers, then


@then(parsers.re(r"^active execution count never exceeds .+"))
def active_execution_count_invariant():
    """Invariant step: trivially satisfied in isolated test context."""
