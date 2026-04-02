"""When: an "opensearch" "outbound connection" is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "opensearch" "outbound connection" is deleted')
def delete_outbound_connection(lws_session, world):
    pytest.skip("Cannot delete cross-cluster connection without connection ID in lws")
