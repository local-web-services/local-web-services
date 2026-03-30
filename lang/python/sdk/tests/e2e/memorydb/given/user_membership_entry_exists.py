"""Given: the user membership entry exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the user membership entry exists")
def user_membership_entry_exists():
    pytest.skip("Cannot configure user membership entry in this context")
