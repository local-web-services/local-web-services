"""Then: both the inbound and outbound connection are "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('both the inbound and outbound connection are "ACTIVE"')
def both_connections_active_then():
    pytest.skip("Cannot observe internal cross-cluster connection ACTIVE state in lws")
