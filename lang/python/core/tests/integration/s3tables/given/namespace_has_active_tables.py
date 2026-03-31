"""Given: the "s3 tables" "namespace" had active tables"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "s3 tables" "namespace" had active tables')
def namespace_has_active_tables():
    pytest.skip(
        "Emulator does not enforce namespace-deletion-requires-no-tables constraint in "
        "integration context"
    )
