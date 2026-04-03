"""Given: the "opensearch" "domain" was "PROCESSING" """

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_DOMAIN


@given('the "opensearch" "domain" was "PROCESSING"')
def domain_is_processing_given(lws_session):
    lws_session.inject_state("opensearch", "domain", TEST_DOMAIN, "processing")
