"""Then: chaos is enabled for the service"""

from __future__ import annotations

from pytest_bdd import then

from ..client import ChaosTestClient
from ..constants import TEST_SERVICE


@then("chaos is enabled for the service")
def then_chaos_is_enabled(lws_session):
    """Verify that chaos is enabled for the test service."""
    status = ChaosTestClient(lws_session).get_chaos_status()
    expected_enabled = True
    actual_enabled = status.get(TEST_SERVICE, {}).get("enabled", False)
    assert actual_enabled == expected_enabled
