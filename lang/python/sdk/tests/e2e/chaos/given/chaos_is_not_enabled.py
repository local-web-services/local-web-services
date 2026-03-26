"""Given: chaos is not enabled for the service"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("chaos is not enabled for the service")
def chaos_is_not_enabled():
    pytest.skip("LWS does not enforce rejection when chaos is not enabled")
