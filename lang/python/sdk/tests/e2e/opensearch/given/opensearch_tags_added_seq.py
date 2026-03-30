"""Given: tags have been added to a domain"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OpensearchTestClient


@given("tags have been added to a domain")
def opensearch_tags_added_seq(lws_session):
    OpensearchTestClient(lws_session).create_domain()
