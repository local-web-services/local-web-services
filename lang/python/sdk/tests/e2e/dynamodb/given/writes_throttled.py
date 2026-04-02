"""Given: "dynamodb" "write" throttling was active"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('"dynamodb" "write" throttling was active')
def writes_throttled():
    pytest.skip("Cannot configure write throttling in this abstract context")
