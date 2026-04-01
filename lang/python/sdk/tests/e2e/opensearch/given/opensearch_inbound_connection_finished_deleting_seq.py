"""Given: an "opensearch" "inbound connection" finishes deleting"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "opensearch" "inbound connection" finishes deleting')
def opensearch_inbound_connection_finished_deleting_seq():
    pytest.skip("Cannot trigger internal inbound connection deletion completion in lws")
