"""Given: the part has already been uploaded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the part has already been uploaded")
def part_already_uploaded():
    pytest.skip("Cannot configure an already-uploaded part in this context")
