"""Then: the default "eventbridge" "bus" cannot be deleted"""

from __future__ import annotations

from pytest_bdd import step


@step('the default "eventbridge" "bus" cannot be deleted')
def default_bus_cannot_be_deleted(lws_session):
    """Invariant: attempting to delete the default bus always raises an error."""
    try:
        lws_session.client("events").delete_event_bus(Name="default")
        actual_deleted = True
    except Exception:
        actual_deleted = False
    assert not actual_deleted, "Expected deleting the default event bus to fail"
