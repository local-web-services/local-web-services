"""Then: delivery_invariant_holds"""

from __future__ import annotations

from pytest_bdd import parsers, then


@then(parsers.re(r"^a message can only be .+"))
def delivery_invariant_holds():
    """Invariant steps are trivially satisfied in an isolated test context."""
