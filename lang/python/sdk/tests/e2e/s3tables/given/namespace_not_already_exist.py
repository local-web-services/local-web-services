"""Given: the "s3 tables" "namespace" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "s3 tables" "namespace" did not already exist')
def namespace_not_already_exist():
    """No-op: fresh bucket has no namespaces."""
