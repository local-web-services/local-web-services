"""Given: the recovery window is not open"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the recovery window is not open")
def recovery_window_not_open_given():
    pytest.skip("Cannot expire the recovery window programmatically")
