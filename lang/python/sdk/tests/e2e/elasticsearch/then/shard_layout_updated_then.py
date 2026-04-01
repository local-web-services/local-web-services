"""Then: the "elasticsearch" "domain" shard layout will be updated without changing document counts"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "elasticsearch" "domain" shard layout will be updated without changing document counts')
def shard_layout_updated_then():
    pytest.skip("Cannot observe internal shard layout changes in lws")
