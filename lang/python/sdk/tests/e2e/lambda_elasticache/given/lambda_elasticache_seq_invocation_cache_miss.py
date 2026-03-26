"""Given: the Lambda invocation has failed because all cache entries have been evicted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda invocation has failed because all cache entries have been evicted")
def lambda_elasticache_seq_invocation_cache_miss():
    pytest.skip("Cannot trigger Lambda invocation in lws")
