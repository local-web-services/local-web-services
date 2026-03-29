"""Given: the domain is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the domain is not "ACTIVE"')
def domain_is_not_active_given():
    pytest.skip("lws does not support non-ACTIVE OpenSearch domain lifecycle states")
