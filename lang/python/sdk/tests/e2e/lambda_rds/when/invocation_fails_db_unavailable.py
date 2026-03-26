"""When: the Lambda function fails to connect because the database is failing over"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda function fails to connect because the database is failing over")
def invocation_fails_db_unavailable(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
