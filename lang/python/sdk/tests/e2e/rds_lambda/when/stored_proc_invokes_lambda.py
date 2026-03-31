"""When: a "RDS" stored procedure invokes the "lambda" "function" and succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "RDS" stored procedure invokes the "lambda" "function" and succeeds')
def stored_proc_invokes_lambda(world):
    pytest.skip("Cannot trigger RDS->Lambda invocation in lws")
