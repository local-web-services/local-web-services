"""Given: an index has been deleted from an active domain"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an index has been deleted from an active domain")
def elasticsearch_seq_index_deleted_from_active_domain():
    pytest.skip("Cannot delete index without connecting to Elasticsearch endpoint in lws")
