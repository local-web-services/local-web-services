"""Given: the Lambda function has written a value to the ElastiCache cluster during invocation"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda function has written a value to the ElastiCache cluster during invocation")
def lambda_elasticache_seq_value_written():
    pytest.skip("Cannot trigger Lambda invocation in lws")
