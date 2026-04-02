"""Given: the "chaos" status for all "services" is retrieved"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ChaosTestClient


@given('the "chaos" status for all "services" is retrieved')
def chaos_status_retrieved(lws_session, world):
    """Retrieve the chaos status for all services."""
    world["chaos_status"] = ChaosTestClient(lws_session).get_chaos_status()
