"""Given: the "elasticsearch" "domain" has a pending configuration change"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticsearch" "domain" has a pending configuration change')
def domain_has_pending_config_change():
    pytest.skip("Cannot trigger internal domain configuration pending state in lws")
