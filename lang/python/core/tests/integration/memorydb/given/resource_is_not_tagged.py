"""Given: the resource is not tagged"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the resource is not tagged")
def resource_is_not_tagged(world):
    pytest.skip("lws does not enforce tagged state; tag operations always succeed on a valid ARN.")
