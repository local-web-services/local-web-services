"""Given: a running execution has exceeded its timeout"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a running execution has exceeded its timeout")
def running_execution_timed_out_given():
    pytest.skip("Cannot pre-set a timed-out execution state for sequence setup")
