"""When: a document is indexed in an active index"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a document is indexed in an active index")
def index_document(lws_session, world):
    pytest.skip("Cannot index a document without connecting to the Elasticsearch endpoint in lws")
