"""Given: the "opensearch" "inbound connection" was "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "opensearch" "inbound connection" was "DELETING"')
def inbound_connection_is_deleting_given():
    pytest.skip("Cannot observe DELETING inbound connection state in lws")
