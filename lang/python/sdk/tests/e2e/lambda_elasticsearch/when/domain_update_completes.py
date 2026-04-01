"""When: the "elasticsearch" "domain" configuration update completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the "elasticsearch" "domain" configuration update completes')
def domain_update_completes(world):
    pytest.skip("Cannot trigger domain update completion in lws")
