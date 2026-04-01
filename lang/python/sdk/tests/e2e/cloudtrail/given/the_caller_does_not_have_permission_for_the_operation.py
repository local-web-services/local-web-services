"""Given: the caller does not have permission for the operation"""

from __future__ import annotations

from pytest_bdd import given


@given("the caller does not have permission for the operation")
def the_caller_does_not_have_permission_for_the_operation():
    """No-op: IAM deny is not configurable per-scenario in the e2e session."""
