"""Given: the domain does not have a pending configuration change"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the domain does not have a pending configuration change")
def es_domain_no_pending_config_change(world):
    pytest.skip("Pending configuration changes not available in stateless integration tests.")
