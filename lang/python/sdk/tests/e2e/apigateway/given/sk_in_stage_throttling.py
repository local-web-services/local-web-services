"""Given: sk in stage_throttling"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("sk in stage_throttling")
def sk_in_stage_throttling():
    pytest.skip("Cannot configure stage throttling state for sequence setup in lws")
