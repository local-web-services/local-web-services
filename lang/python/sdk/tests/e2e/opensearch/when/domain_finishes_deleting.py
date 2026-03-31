"""When: an "opensearch" "domain" finishes deleting"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "opensearch" "domain" finishes deleting')
def domain_finishes_deleting(lws_session, world):
    pytest.skip("Cannot trigger internal OpenSearch domain deletion completion in lws")
