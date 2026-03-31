"""Given: the "opensearch" "tag key" existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "opensearch" "tag key" existed')
def tag_key_exists():
    pytest.skip("Cannot configure domain tags in this context")
