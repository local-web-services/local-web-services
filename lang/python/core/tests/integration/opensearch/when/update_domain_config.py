"""When: a domain configuration update is requested"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("a domain configuration update is requested")
def update_domain_config(client: TestClient, world: dict):
    pytest.skip("UpdateDomainConfig is not yet implemented in lws.")
