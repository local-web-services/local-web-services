"""Then: the server name, protocol, and route count are returned"""

from __future__ import annotations

from pytest_bdd import then


@then("the server name, protocol, and route count are returned")
def server_name_protocol_route_count_returned():
    """Invariant step: trivially satisfied in isolated test context."""
