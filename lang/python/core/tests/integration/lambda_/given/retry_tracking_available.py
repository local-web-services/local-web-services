"""Given: "lambda" "async" "slot" retry tracking was available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('"lambda" "async" "slot" retry tracking was available')
def retry_tracking_available(world):
    pytest.skip("Cannot configure retry tracking in integration tests.")
