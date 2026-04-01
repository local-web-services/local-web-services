"""Then: the "elasticsearch" "index" will be "ACTIVE" with zero documents"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "elasticsearch" "index" will be "ACTIVE" with zero documents')
def index_is_active_then():
    pytest.skip(
        "Cannot observe index state without connecting to the Elasticsearch endpoint in lws"
    )
