"""
Given: an "RDS" stored procedure has failed to invoke Lambda because the function has been
deleted
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'an "RDS" stored procedure has failed to invoke Lambda because the function has been deleted'
)
def rds_stored_proc_failed_function_deleted():
    pytest.skip("Cannot trigger RDS->Lambda invocation in lws")
