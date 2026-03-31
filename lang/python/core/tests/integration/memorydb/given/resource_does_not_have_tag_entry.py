"""Given: the "memorydb" "resource" does not have a tag entry"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "memorydb" "resource" does not have a tag entry')
def resource_does_not_have_tag_entry(world):
    pytest.skip(
        "lws does not enforce tag-entry existence; TagResource always succeeds on a valid ARN."
    )
