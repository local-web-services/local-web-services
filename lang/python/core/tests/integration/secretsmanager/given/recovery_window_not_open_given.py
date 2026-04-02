"""Given: the "secretsmanager" "recovery window" was not "open" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "secretsmanager" "recovery window" was not "open"')
def recovery_window_not_open_given(world):
    pytest.skip("Cannot expire the recovery window programmatically.")
