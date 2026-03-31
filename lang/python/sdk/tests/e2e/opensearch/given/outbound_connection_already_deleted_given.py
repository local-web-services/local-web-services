"""Given: the "opensearch" "outbound connection" is already "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "opensearch" "outbound connection" is already "DELETED"')
def outbound_connection_already_deleted_given():
    pytest.skip("Cannot use a deleted connection as a precondition in lws")
