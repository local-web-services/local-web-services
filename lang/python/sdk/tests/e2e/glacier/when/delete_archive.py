"""When: a "glacier" "archive" is deleted from a "glacier" "vault" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "glacier" "archive" is deleted from a "glacier" "vault"')
def delete_archive(lws_session, world):
    pytest.skip("Cannot delete a specific archive without first retrieving its ID in lws")
