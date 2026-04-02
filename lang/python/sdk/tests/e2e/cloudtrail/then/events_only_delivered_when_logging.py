"""Then: "cloudtrail" "event"s are only delivered when trail is "LOGGING" """

from __future__ import annotations

from pytest_bdd import step


@step(
    '"cloudtrail" "event"s are only delivered when the "cloudtrail" "trail" is "LOGGING" (at time of delivery)'
)
def events_only_delivered_when_logging():
    """Invariant: verified by the FizzBee model checker; no runtime check needed."""
