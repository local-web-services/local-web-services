"""Given: "dynamodb" "read" throttling was active"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('"dynamodb" "read" throttling was active')
def reads_throttled():
    pytest.skip("Cannot configure read throttling in this abstract context")
