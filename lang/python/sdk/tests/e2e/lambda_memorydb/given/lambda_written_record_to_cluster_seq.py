"""
Given: the Lambda function has written a record to the "AVAILABLE" MemoryDB cluster during
invocation
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'the Lambda function has written a record to the "AVAILABLE" MemoryDB cluster during invocation'
)
def lambda_written_record_to_cluster_seq():
    pytest.skip("Cannot trigger Lambda MemoryDB write in lws")
