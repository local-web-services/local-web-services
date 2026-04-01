"""Given: an "opensearch" "index" is created in the "opensearch" "domain" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "opensearch" "index" is created in the "opensearch" "domain"')
def opensearch_index_has_been_created_seq():
    pytest.skip("Cannot create an OpenSearch index in lws")
