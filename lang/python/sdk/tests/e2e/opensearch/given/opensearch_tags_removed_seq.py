"""Given: tags are removed from an "opensearch" "domain" """

from __future__ import annotations

from pytest_bdd import given

from ..client import OpensearchTestClient


@given('tags are removed from an "opensearch" "domain"')
def opensearch_tags_removed_seq(lws_session):
    OpensearchTestClient(lws_session).create_domain()
