"""Given: an "opensearch" "outbound connection" finishes deleting"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "opensearch" "outbound connection" finishes deleting')
def opensearch_outbound_connection_finished_deleting_seq():
    pytest.skip("Cannot trigger internal outbound connection deletion completion in lws")
