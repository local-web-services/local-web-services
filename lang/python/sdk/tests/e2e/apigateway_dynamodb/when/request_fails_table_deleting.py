"""When: a request is received but the DynamoDB write fails because the table is being deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a request is received but the DynamoDB write fails because the table is being deleted")
def request_fails_table_deleting(world):
    pytest.skip("Cannot simulate DELETING table during request in lws")
