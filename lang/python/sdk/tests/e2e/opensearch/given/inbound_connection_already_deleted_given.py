"""Given: the inbound connection is already "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the inbound connection is already "DELETED"')
def inbound_connection_already_deleted_given():
    pytest.skip("Cannot use a deleted inbound connection as a precondition in lws")
