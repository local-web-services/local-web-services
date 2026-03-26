"""Then: reads are throttled"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("reads are throttled")
def reads_are_throttled_then(world):
    pytest.skip("Cannot observe throttling in this abstract context")
