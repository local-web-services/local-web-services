"""Then: the "opensearch" "inbound connection" will be "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "opensearch" "inbound connection" will be "DELETED"')
def inbound_connection_deleted_then():
    pytest.skip("Cannot observe internal inbound connection deletion in lws")
