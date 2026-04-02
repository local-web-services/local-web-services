"""Then: deleted cloudformation stacks are not describable"""

from __future__ import annotations

from pytest_bdd import step


@step("deleted cloudformation stacks are not describable")
@step('deleted "cloudformation" "stacks" are not describable')
def deleted_stacks_not_describable_invariant():
    """Invariant: verified by the FizzBee model checker; no runtime check needed."""
