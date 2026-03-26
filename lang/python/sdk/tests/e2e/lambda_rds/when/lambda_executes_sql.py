"""When: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds')
def lambda_executes_sql(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
