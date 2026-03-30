"""Given: the table does not have a policy"""

from __future__ import annotations

from pytest_bdd import given


@given("the table does not have a policy")
def table_does_not_have_a_policy():
    """No-op: fresh tables have no policy by default."""
