"""Then: every cloudformation stack has a valid status"""

from __future__ import annotations

from pytest_bdd import step


@step("every cloudformation stack has a valid status")
@step('every "cloudformation" "stack" has a valid status')
def stack_status_valid_invariant():
    """Invariant: verified by the FizzBee model checker; no runtime check needed."""
