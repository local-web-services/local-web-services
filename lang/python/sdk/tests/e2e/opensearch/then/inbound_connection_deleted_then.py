"""Then: the inbound connection is "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the inbound connection is "DELETED"')
def inbound_connection_deleted_then():
    pytest.skip("Cannot observe internal inbound connection deletion in lws")
