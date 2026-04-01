"""When: a running "step functions" "execution" fails"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a running "step functions" "execution" fails')
def running_execution_fails(world):
    pytest.skip("Cannot trigger internal execution failure in lws")
