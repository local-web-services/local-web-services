"""When: a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds'
)
def execution_queries_db_succeeds(world):
    pytest.skip("Cannot trigger internal execution step that queries RDS DB in lws")
