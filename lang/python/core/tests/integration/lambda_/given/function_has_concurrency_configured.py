"""Given: the function has concurrency configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the function has concurrency configured")
def function_has_concurrency_configured(world):
    pytest.skip("Cannot configure concurrency in integration tests without creating first.")
