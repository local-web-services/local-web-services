"""Then: the outbound connection is in "DELETING" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the outbound connection is in "DELETING" state')
def outbound_connection_deleting_then():
    pytest.skip("Cannot observe internal outbound connection DELETING state in lws")
