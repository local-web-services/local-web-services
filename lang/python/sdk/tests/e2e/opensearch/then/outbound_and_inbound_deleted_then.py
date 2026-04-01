"""Then: the outbound and associated inbound connection will be "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the outbound and associated inbound connection will be "DELETED"')
def outbound_and_inbound_deleted_then():
    pytest.skip("Cannot observe internal cross-cluster connection deletion in lws")
