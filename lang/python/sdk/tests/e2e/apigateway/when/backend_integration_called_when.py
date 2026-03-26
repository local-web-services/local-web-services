"""When: a backend integration is called"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a backend integration is called")
def backend_integration_called_when(world):
    pytest.skip("Cannot simulate backend integration calls in this context")
