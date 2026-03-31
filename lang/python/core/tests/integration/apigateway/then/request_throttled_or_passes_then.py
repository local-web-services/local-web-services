"""Then: the request will be throttled or pass non-deterministically"""

from __future__ import annotations

from pytest_bdd import then


@then("the request will be throttled or pass non-deterministically")
def request_throttled_or_passes_then(world):
    """No-op: non-deterministic throttling behaviour is acceptable in lws."""
