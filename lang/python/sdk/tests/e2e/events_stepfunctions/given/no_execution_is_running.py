"""Given: no execution is "RUNNING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no execution is "RUNNING"')
def no_execution_is_running():
    pytest.skip("Cannot test failure when no execution is RUNNING in isolated context")
