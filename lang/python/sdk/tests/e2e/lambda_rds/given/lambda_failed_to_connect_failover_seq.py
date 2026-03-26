"""Given: the Lambda function has failed to connect because the database is failing over"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda function has failed to connect because the database is failing over")
def lambda_failed_to_connect_failover_seq():
    pytest.skip("Cannot trigger Lambda RDS connection failure in lws")
