"""Given: a search domain has finished deleting"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a search domain has finished deleting")
def opensearch_search_domain_finished_deleting_seq():
    pytest.skip("Cannot trigger internal OpenSearch domain deletion completion in lws")
