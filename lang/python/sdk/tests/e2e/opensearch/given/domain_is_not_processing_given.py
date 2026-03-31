"""Given: the "opensearch" "domain" was not "PROCESSING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "opensearch" "domain" was not "PROCESSING"')
def domain_is_not_processing_given():
    """No-op: domains are not in PROCESSING state by default."""
