"""Given: an "opensearch" "domain" finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "opensearch" "domain" finishes creating')
def opensearch_search_domain_finished_creating_seq():
    pytest.skip("Cannot trigger internal OpenSearch domain creation completion in lws")
