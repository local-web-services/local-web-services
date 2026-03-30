"""Given: tags have been removed from a domain"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OpensearchTestClient


@given("tags have been removed from a domain")
def opensearch_tags_removed_seq(lws_session):
    OpensearchTestClient(lws_session).create_domain()
