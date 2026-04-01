"""Given: the "glacier" "archive" was not "STORED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "glacier" "archive" was not "STORED"')
def archive_is_not_stored(world):
    pytest.skip(
        "Lifecycle-dependent state (non-STORED archive) is not supported "
        "in stateless integration tests."
    )
