"""Given: an automatic rotation event has occurred for an active secret"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an automatic rotation event has occurred for an active secret")
def secretsmanager_automatic_rotation_event_has_occurred():
    pytest.skip("Cannot simulate automatic rotation event in lws")
