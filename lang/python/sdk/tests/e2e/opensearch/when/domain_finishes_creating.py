"""When: an "opensearch" "domain" finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "opensearch" "domain" finishes creating')
def domain_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal OpenSearch domain creation completion in lws")
