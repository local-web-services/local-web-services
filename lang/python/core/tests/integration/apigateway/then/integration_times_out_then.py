"""Then: the "api gateway" "integration" times out or responds non-deterministically"""

from __future__ import annotations

from pytest_bdd import then


@then('the "api gateway" "integration" times out or responds non-deterministically')
def integration_times_out_then(world):
    """No-op: non-deterministic backend integration behaviour is acceptable in lws."""
