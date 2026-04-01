"""Given: the dev stage has throttling configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the dev stage has throttling configured")
def dev_stage_has_throttling_configured(world):
    pytest.skip("Stage throttling configuration is not supported in stateless integration tests.")
