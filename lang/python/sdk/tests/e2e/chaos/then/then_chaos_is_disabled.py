"""Then: "chaos" will be disabled for the "service" """

from __future__ import annotations

from pytest_bdd import then

from ..client import ChaosTestClient
from ..constants import TEST_SERVICE


@then('"chaos" will be disabled for the "service"')
def then_chaos_is_disabled(lws_session):
    """Verify that chaos is disabled for the test service."""
    status = ChaosTestClient(lws_session).get_chaos_status()
    expected_enabled = False
    actual_enabled = status.get(TEST_SERVICE, {}).get("enabled", True)
    assert actual_enabled == expected_enabled
