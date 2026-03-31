"""Given: the "elasticsearch" "domain" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticsearch" "domain" did not exist')
def domain_does_not_exist():
    """No-op: fresh state has no Elasticsearch domains."""
