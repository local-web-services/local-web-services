"""When: write throttling is toggled on or off"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("write throttling is toggled on or off")
def toggle_write_throttling(world):
    pytest.skip("Cannot toggle write throttling in this abstract context")
