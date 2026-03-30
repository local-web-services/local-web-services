"""When: a domain configuration update begins"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a domain configuration update begins")
def domain_configuration_update_begins(lws_session, world):
    pytest.skip("Cannot trigger internal Elasticsearch domain configuration update in lws")
