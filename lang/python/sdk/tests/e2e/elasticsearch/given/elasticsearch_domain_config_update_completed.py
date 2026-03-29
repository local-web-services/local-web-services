"""Given: the domain configuration update has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the domain configuration update has completed")
def elasticsearch_domain_config_update_completed():
    pytest.skip(
        "Cannot trigger internal Elasticsearch domain configuration update completion in lws"
    )
