"""When: an "RDS" stored procedure invokes the Lambda function and succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "RDS" stored procedure invokes the Lambda function and succeeds')
def stored_proc_invokes_lambda(world):
    pytest.skip("Cannot trigger RDS->Lambda invocation in lws")
