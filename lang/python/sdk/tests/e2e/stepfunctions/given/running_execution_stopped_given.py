"""Given: a running execution has been stopped"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a running execution has been stopped")
def running_execution_stopped_given():
    pytest.skip("Cannot pre-set a stopped execution state for sequence setup")
