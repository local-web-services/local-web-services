"""Given: a running execution has failed to read the parameter because it has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a running execution has failed to read the parameter because it has been deleted")
def running_execution_failed_parameter_deleted_given():
    pytest.skip("Cannot pre-set a failed execution SSM task state for sequence setup")
