"""When: an index is deleted from an active domain"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("an index is deleted from an active domain")
def delete_index(lws_session, world):
    pytest.skip("Cannot delete an index without connecting to the Elasticsearch endpoint in lws")
