"""Given: the domain is not "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the domain is not "AVAILABLE"')
def domain_is_not_available_given():
    pytest.skip("lws does not support non-AVAILABLE Elasticsearch domain lifecycle states")
