"""Given: the execution was not "RUNNING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the execution was not "RUNNING"')
def execution_is_not_running_given():
    pytest.skip("Cannot configure execution in non-RUNNING state in integration test context")
