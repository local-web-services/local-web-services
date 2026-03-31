"""Given: the "s3 tables" "table" does not have a policy"""

from __future__ import annotations

from pytest_bdd import given


@given('the "s3 tables" "table" does not have a policy')
def table_does_not_have_policy():
    """No-op: fresh tables have no policies."""
