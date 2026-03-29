"""Given: the inbound connection is already "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the inbound connection is already "DELETING"')
def inbound_connection_already_deleting_given():
    pytest.skip("Cannot observe DELETING inbound connection state in lws")
