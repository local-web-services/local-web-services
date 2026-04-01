"""Given: the "elasticsearch" "domain" was not "PROCESSING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticsearch" "domain" was not "PROCESSING"')
def domain_is_not_processing():
    """No-op: domains are not PROCESSING in fresh state."""
