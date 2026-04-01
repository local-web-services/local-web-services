"""Given: the "s3 tables" "namespace" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "s3 tables" "namespace" did not exist')
def namespace_does_not_exist():
    """No-op: fresh bucket has no namespaces."""
