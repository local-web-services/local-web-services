"""Given: the "opensearch" "inbound connection" was "PENDING_ACCEPTANCE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "opensearch" "inbound connection" was "PENDING_ACCEPTANCE"')
def inbound_connection_is_pending_given():
    pytest.skip("Cannot observe PENDING_ACCEPTANCE inbound connection state in lws")
