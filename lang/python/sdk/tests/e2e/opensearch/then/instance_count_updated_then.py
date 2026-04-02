"""Then: the "opensearch" "domain" instance count will be updated without data loss"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "opensearch" "domain" instance count will be updated without data loss')
def instance_count_updated_then():
    pytest.skip("Cannot observe internal shard rebalancing in lws")
