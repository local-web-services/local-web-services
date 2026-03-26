"""Then: the index is "ACTIVE" with zero documents"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the index is "ACTIVE" with zero documents')
def index_is_active_then():
    pytest.skip(
        "Cannot observe index state without connecting to the Elasticsearch endpoint in lws"
    )
