"""Given: throttling was not "ENABLED" for the "api gateway" "prod stage" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('throttling was not "ENABLED" for the "api gateway" "prod stage"')
def throttling_enabled_for_prod_stage():
    pytest.skip("Cannot configure stage throttling state for sequence setup in lws")
