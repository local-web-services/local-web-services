"""Given: throttling was "ENABLED" for the "api gateway" "prod stage" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('throttling was "ENABLED" for the "api gateway" "prod stage"')
def throttling_enabled_prod():
    pytest.skip("Cannot configure stage throttling in this abstract context")
