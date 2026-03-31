"""Given: the "memorydb" "resource" has a tag entry"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "memorydb" "resource" has a tag entry')
def resource_has_tag_entry_guard():
    pytest.skip("Cannot configure resource tags in this context")
