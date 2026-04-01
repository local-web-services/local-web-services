"""Given: the remote "opensearch" "domain" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OpensearchTestClient
from ..constants import TEST_DOMAIN_2


@given('the remote "opensearch" "domain" existed')
def remote_domain_exists(lws_session):
    OpensearchTestClient(lws_session).create_domain(domain_name=TEST_DOMAIN_2)
