"""When: a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update'
)
def execution_fails_domain_processing(world):
    pytest.skip(
        "Cannot trigger internal execution step that fails due to "
        "Elasticsearch domain processing in lws"
    )
