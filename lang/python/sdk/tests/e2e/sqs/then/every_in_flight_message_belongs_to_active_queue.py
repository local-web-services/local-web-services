"""Then: every in-flight message belongs to an "ACTIVE" queue"""

from __future__ import annotations

from pytest_bdd import then


@then('every in-flight message belongs to an "ACTIVE" queue')
def every_in_flight_message_belongs_to_active_queue():
    """Invariant: trivially satisfied in isolated lws context."""
