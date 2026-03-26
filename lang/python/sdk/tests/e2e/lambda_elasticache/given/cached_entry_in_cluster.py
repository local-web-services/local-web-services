"""Given: a "CACHED" entry exists in the cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "CACHED" entry exists in the cluster')
def cached_entry_in_cluster():
    pytest.skip("Cannot pre-populate ElastiCache entries in lws")
