"""Given: throttling is enabled for the dev stage"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("throttling is enabled for the dev stage")
def throttling_enabled_dev():
    pytest.skip("Cannot configure stage throttling in this abstract context")
