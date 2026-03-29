"""Given: the dev stage has throttling configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the dev stage has throttling configured")
def dev_stage_has_throttling_configured():
    pytest.skip("Cannot configure stage throttling in this abstract context")
