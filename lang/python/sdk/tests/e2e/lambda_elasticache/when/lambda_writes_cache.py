"""When: the Lambda function writes a value to the ElastiCache cluster during invocation"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda function writes a value to the ElastiCache cluster during invocation")
def lambda_writes_cache(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
