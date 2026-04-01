"""Given: the "elasticache" "cluster" was not already the primary"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticache" "cluster" was not already the primary')
def cluster_is_not_already_primary():
    pytest.skip("Cannot control cluster primary assignment in lws")
