"""Given: tags are removed from a MemoryDB resource"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("tags are removed from a MemoryDB resource")
def memorydb_tags_removed_seq():
    pytest.skip("Cannot construct MemoryDB ARN for tag operations in this context")
