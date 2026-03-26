"""Given: a running execution has queried the "AVAILABLE" "DB" instance and the task succeeded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a running execution has queried the "AVAILABLE" "DB" instance and the task succeeded')
def running_execution_queried_db_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution RDS task state for sequence setup")
