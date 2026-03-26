"""
When: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation')
def lambda_writes_record(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
