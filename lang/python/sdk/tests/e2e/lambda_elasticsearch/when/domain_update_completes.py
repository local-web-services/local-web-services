"""When: the domain configuration update completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the domain configuration update completes")
def domain_update_completes(world):
    pytest.skip("Cannot trigger domain update completion in lws")
