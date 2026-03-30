"""Given: the associated inbound connection exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the associated inbound connection exists")
def associated_inbound_connection_exists():
    pytest.skip("Cannot create an associated inbound connection as a precondition in this context")
