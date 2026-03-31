"""When: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "elasticsearch" "index" is created in an active "elasticsearch" "domain"')
def create_index(lws_session, world):
    pytest.skip("Cannot create an index without connecting to the Elasticsearch endpoint in lws")
