"""Then: the index is marked as "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the index is marked as "DELETED"')
def index_is_deleted_then():
    pytest.skip("Cannot observe index deletion without connecting to endpoint in lws")
