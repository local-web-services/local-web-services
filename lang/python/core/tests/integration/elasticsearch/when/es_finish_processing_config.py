"""When: a domain finishes processing its configuration update"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("a domain finishes processing its configuration update")
def es_finish_processing_config(client: TestClient, world: dict):
    pytest.skip("UpdateElasticsearchDomainConfig is not yet implemented in lws.")
