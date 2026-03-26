"""Then: both the inbound and outbound connection are "REJECTED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('both the inbound and outbound connection are "REJECTED"')
def both_connections_rejected_then():
    pytest.skip("Cannot observe internal cross-cluster connection REJECTED state in lws")
