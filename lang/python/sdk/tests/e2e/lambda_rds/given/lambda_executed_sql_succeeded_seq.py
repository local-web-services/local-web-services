"""
Given: the Lambda function has executed a "SQL" query against the "AVAILABLE" database and
succeeded
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'the Lambda function has executed a "SQL" query against the "AVAILABLE" database and succeeded'
)
def lambda_executed_sql_succeeded_seq():
    pytest.skip("Cannot trigger Lambda RDS SQL execution in lws")
