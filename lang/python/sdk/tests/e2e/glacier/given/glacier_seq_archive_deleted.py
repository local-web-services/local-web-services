"""Given: an archive has been deleted from a vault"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an archive has been deleted from a vault")
def glacier_seq_archive_deleted():
    pytest.skip("Cannot delete a specific archive without first retrieving its ID in lws")
