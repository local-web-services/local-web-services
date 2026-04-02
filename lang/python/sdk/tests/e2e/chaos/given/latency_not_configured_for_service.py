"""Given: "chaos" "latency" is not configured for the "service" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('"chaos" "latency" is not configured for the "service"')
def latency_not_configured_for_service():
    pytest.skip("LWS does not enforce rejection when latency is not configured")
