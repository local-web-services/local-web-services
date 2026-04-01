"""Given: the "opensearch" "domain" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "opensearch" "domain" did not already exist')
def domain_not_already_exist():
    """No-op: fresh state has no OpenSearch domains."""
