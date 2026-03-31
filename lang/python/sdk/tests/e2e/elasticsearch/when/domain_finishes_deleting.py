"""When: an "elasticsearch" "domain" finishes deleting"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "elasticsearch" "domain" finishes deleting')
def domain_finishes_deleting(lws_session, world):
    pytest.skip("Cannot trigger internal Elasticsearch domain deletion completion in lws")
