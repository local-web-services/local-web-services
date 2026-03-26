"""Given: an index has been created in an active domain"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an index has been created in an active domain")
def elasticsearch_seq_index_created_in_active_domain():
    pytest.skip("Cannot create index without connecting to Elasticsearch endpoint in lws")
