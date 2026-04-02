"""Given: tags are added to a "memorydb" "resource" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('tags are added to a "memorydb" "resource"')
def memorydb_tags_added_seq():
    pytest.skip("Cannot construct MemoryDB ARN for tag operations in this context")
