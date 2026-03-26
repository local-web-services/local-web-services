"""When: the domain configuration update completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the domain configuration update completes")
def domain_configuration_update_completes(world):
    pytest.skip("Cannot trigger internal OpenSearch domain processing completion in lws")
