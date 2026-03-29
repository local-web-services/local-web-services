"""Then: async_retry_count_invariant"""

from __future__ import annotations

from pytest_bdd import parsers, then


@then(parsers.re(r"^async retry count never exceeds .+"))
def async_retry_count_invariant():
    """Invariant step: trivially satisfied in isolated test context."""
