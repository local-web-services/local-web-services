"""When: an archive is deleted from a vault"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("an archive is deleted from a vault")
def delete_archive(lws_session, world):
    pytest.skip("Cannot delete a specific archive without first retrieving its ID in lws")
