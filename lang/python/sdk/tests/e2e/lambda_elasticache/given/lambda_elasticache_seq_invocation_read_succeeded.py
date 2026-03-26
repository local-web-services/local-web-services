"""Given: the Lambda invocation has read an existing cache entry and completed successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda invocation has read an existing cache entry and completed successfully")
def lambda_elasticache_seq_invocation_read_succeeded():
    pytest.skip("Cannot trigger Lambda invocation in lws")
