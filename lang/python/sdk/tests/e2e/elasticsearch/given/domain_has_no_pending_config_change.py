"""Given: the "elasticsearch" "domain" does not have a pending configuration change"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticsearch" "domain" does not have a pending configuration change')
def domain_has_no_pending_config_change():
    pytest.skip("lws does not model pending configuration changes as an enforceable precondition")
