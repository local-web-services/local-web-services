"""Given: the domain is not "PROCESSING" """

from __future__ import annotations

from pytest_bdd import given


@given('the domain is not "PROCESSING"')
def domain_is_not_processing_given():
    """No-op: domains are not in PROCESSING state by default."""
