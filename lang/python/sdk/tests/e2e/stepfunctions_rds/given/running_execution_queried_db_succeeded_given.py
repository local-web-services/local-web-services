"""Given: a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds'
)
def running_execution_queried_db_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution RDS task state for sequence setup")
