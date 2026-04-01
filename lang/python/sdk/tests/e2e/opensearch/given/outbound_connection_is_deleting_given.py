"""Given: the "opensearch" "outbound connection" was "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "opensearch" "outbound connection" was "DELETING"')
def outbound_connection_is_deleting_given():
    pytest.skip("Cannot observe DELETING outbound connection state in lws")
