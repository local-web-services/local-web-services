"""Given: an index has been created in the OpenSearch domain"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an index has been created in the OpenSearch domain")
def opensearch_index_has_been_created_seq():
    pytest.skip("Cannot create an OpenSearch index in lws")
