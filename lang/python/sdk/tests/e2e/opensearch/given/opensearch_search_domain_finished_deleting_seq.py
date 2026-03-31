"""Given: an "opensearch" "domain" finishes deleting"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "opensearch" "domain" finishes deleting')
def opensearch_search_domain_finished_deleting_seq():
    pytest.skip("Cannot trigger internal OpenSearch domain deletion completion in lws")
