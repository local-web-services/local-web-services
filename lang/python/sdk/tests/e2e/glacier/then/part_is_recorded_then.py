"""Then: the part is recorded for the upload"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the part is recorded for the upload")
def part_is_recorded_then():
    pytest.skip("Cannot observe part recording in lws")
