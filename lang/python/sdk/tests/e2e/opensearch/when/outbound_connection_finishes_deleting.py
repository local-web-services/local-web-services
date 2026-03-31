"""When: an "opensearch" "outbound connection" finishes deleting"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "opensearch" "outbound connection" finishes deleting')
def outbound_connection_finishes_deleting(lws_session, world):
    pytest.skip("Cannot trigger internal outbound connection deletion completion in lws")
