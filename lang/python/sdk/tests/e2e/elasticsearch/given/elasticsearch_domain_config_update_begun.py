"""Given: a domain configuration update has begun"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a domain configuration update has begun")
def elasticsearch_domain_config_update_begun():
    pytest.skip("Cannot trigger internal Elasticsearch domain configuration update in lws")
