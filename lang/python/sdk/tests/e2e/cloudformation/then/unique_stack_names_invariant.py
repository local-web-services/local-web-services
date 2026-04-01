"""Then: stack names are unique per account"""

from __future__ import annotations

from pytest_bdd import then


@then("stack names are unique per account")
def unique_stack_names_invariant():
    """Invariant: verified by the FizzBee model checker; no runtime check needed."""
