"""Then: the document count for the index increases by one"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the document count for the index increases by one")
def document_count_increases_then():
    pytest.skip("Cannot observe document count without connecting to endpoint in lws")
