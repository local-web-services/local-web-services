"""Then: the instance count is updated without data loss"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the instance count is updated without data loss")
def instance_count_updated_then():
    pytest.skip("Cannot observe internal shard rebalancing in lws")
