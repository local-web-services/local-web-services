"""Given: a search domain has finished creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a search domain has finished creating")
def opensearch_search_domain_finished_creating_seq():
    pytest.skip("Cannot trigger internal OpenSearch domain creation completion in lws")
