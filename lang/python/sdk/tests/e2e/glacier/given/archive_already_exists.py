"""Given: the archive already exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the archive already exists")
def archive_already_exists(lws_session):
    pytest.skip(
        "Cannot enforce duplicate archive rejection in lws; each upload creates a unique archive ID"
    )
