"""Given: an admin updates attributes for a confirmed user"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an admin updates attributes for a confirmed user")
def cognito_idp_admin_updated_attributes():
    pytest.skip("Cannot represent an admin attribute update as sequence setup in lws")
