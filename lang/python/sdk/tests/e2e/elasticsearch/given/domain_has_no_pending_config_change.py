"""Given: the "elasticsearch" "domain" does not have a pending configuration change"""

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticsearch" "domain" does not have a pending configuration change')
def domain_has_no_pending_config_change():
    """No-op: domains have no pending config changes by default."""
