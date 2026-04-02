"""Given: no "sts" "session" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('no "sts" "session" "slot" was "available"')
def no_session_slot_available():
    """No-op: STS has no session slot limit in lws."""
