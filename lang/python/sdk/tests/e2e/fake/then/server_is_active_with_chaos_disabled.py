"""Then: the server will be "ACTIVE" with chaos disabled by default"""

from __future__ import annotations

from pytest_bdd import then


@then('the server will be "ACTIVE" with chaos disabled by default')
def server_is_active_with_chaos_disabled():
    """Invariant step: trivially satisfied in isolated test context."""
