"""Given: the prod stage does not have throttling configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the prod stage does not have throttling configured")
def prod_stage_does_not_have_throttling_configured(world):
    pytest.skip("Stage throttling configuration is not supported in stateless integration tests.")
