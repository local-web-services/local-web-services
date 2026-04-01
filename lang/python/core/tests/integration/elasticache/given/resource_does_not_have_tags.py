"""Given: the "elasticache" "resource" does not have tags"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticache" "resource" does not have tags')
def resource_does_not_have_tags(world):
    pytest.skip("lws does not enforce tag preconditions for tag operations.")
