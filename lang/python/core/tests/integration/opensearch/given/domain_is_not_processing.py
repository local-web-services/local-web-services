"""Given: the domain is not "PROCESSING" """

from __future__ import annotations

from pytest_bdd import given


@given('the domain is not "PROCESSING"')
def domain_is_not_processing():
    """No-op: domains are not PROCESSING in fresh state."""
