"""When: a running "step functions" "execution" completes successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a running "step functions" "execution" completes successfully')
def execution_completes(world):
    pytest.skip("Cannot observe internal execution completion in lws")
