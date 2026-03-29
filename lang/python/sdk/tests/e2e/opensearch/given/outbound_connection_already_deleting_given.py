"""Given: the outbound connection is already "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the outbound connection is already "DELETING"')
def outbound_connection_already_deleting_given():
    pytest.skip("Cannot observe DELETING connection state in lws")
