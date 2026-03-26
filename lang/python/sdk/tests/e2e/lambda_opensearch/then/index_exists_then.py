"""Then: the index "EXISTS" and is ready to receive documents"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the index "EXISTS" and is ready to receive documents')
def index_exists_then(world):
    pytest.skip("Cannot observe OpenSearch index creation result in lws")
