"""
Given: the Lambda function has executed a graph query against the "AVAILABLE" cluster and
succeeded
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'the Lambda function has executed a graph query against the "AVAILABLE" cluster and succeeded'
)
def lambda_executed_graph_query_succeeded_seq():
    pytest.skip("Cannot trigger Lambda Neptune query in lws")
