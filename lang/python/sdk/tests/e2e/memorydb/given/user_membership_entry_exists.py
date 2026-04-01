"""Given: the "memorydb" "user" membership entry existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "memorydb" "user" membership entry existed')
def user_membership_entry_exists():
    pytest.skip("Cannot configure user membership entry in this context")
