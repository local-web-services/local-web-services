"""Given: a document has been indexed in an active index"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a document has been indexed in an active index")
def elasticsearch_seq_document_indexed_in_active_index():
    pytest.skip("Cannot index document without connecting to Elasticsearch endpoint in lws")
