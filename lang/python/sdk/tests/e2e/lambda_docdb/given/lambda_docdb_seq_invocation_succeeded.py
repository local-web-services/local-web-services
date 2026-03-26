"""
Given: the Lambda function has written a document to the "AVAILABLE" DocumentDB cluster and
succeeded
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'the Lambda function has written a document to the "AVAILABLE" DocumentDB cluster and succeeded'
)
def lambda_docdb_seq_invocation_succeeded():
    pytest.skip("Cannot trigger Lambda invocation in lws")
