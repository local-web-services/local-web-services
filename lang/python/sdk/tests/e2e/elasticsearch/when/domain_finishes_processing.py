"""When: an "elasticsearch" "domain" finishes processing its configuration update"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "elasticsearch" "domain" finishes processing its configuration update')
def domain_finishes_processing(lws_session, world):
    pytest.skip("Cannot trigger internal Elasticsearch domain configuration processing in lws")
