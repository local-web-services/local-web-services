"""Given: the "glacier" "upload" part has already been uploaded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "glacier" "upload" part has already been uploaded')
def part_already_uploaded(world):
    pytest.skip("Multipart upload operations are not yet implemented in the lws Glacier provider.")
