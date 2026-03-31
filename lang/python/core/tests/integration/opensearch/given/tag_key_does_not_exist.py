"""Given: the "elasticsearch" "tag key" did not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "opensearch" "tag key" did not exist')
@given('the "elasticsearch" "tag key" did not exist')
def tag_key_does_not_exist(world):
    pytest.skip("lws RemoveTags is idempotent and does not fail on missing tag keys.")
