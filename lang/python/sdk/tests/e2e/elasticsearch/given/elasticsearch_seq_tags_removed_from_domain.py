"""Given: tags have been removed from a domain"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticsearchTestClient
from ..constants import TEST_DOMAIN


@given("tags have been removed from a domain")
def elasticsearch_seq_tags_removed_from_domain(lws_session):
    ElasticsearchTestClient(lws_session).create_domain()
    ElasticsearchTestClient(lws_session).add_tags(
        ARN=f"arn:aws:es:us-east-1:000000000000:domain/{TEST_DOMAIN}",
        TagList=[{"Key": "e2e-test-tag-key-1", "Value": "test-tag-value-1"}],
    )
    ElasticsearchTestClient(lws_session).remove_tags(
        ARN=f"arn:aws:es:us-east-1:000000000000:domain/{TEST_DOMAIN}",
        TagKeys=["e2e-test-tag-key-1"],
    )
