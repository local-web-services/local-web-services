"""Given: a running "step functions" "execution" fails to query the "DB" because it is failing over"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a running "step functions" "execution" fails to query the "DB" because it is failing over')
def running_execution_failed_db_failing_over_given():
    pytest.skip("Cannot pre-set a failed execution RDS task state for sequence setup")
