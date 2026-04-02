"""When: an "rds" stored procedure fails to invoke "lambda" because the "lambda" "function" has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'an "rds" stored procedure fails to invoke "lambda" because the "lambda" "function" has been deleted'
)
def stored_proc_fails_function_deleted(world):
    pytest.skip("Cannot trigger RDS->Lambda invocation in lws")
