"""When: a running "step functions" "execution" completes successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a running "step functions" "execution" completes successfully')
def running_execution_succeeds(world):
    pytest.skip("Cannot trigger internal execution completion in lws")
