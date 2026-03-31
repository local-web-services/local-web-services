"""When: an "elasticsearch" "domain" finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "elasticsearch" "domain" finishes creating')
def domain_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal Elasticsearch domain creation completion in lws")
