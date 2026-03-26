"""Given: a running execution has read an existing parameter and the task succeeded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a running execution has read an existing parameter and the task succeeded")
def running_execution_read_parameter_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution SSM task state for sequence setup")
