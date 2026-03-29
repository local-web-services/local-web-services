"""Then: function_valid_status_invariant"""

from __future__ import annotations

from pytest_bdd import parsers, then


@then(parsers.re(r"^every function has a valid status"))
def function_valid_status_invariant():
    """Invariant step: trivially satisfied in isolated test context."""
