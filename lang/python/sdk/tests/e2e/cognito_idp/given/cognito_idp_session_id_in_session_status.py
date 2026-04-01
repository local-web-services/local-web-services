"""Given: session_id in session_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("session_id in session_status")
def cognito_idp_session_id_in_session_status():
    pytest.skip("Cannot represent an active Cognito auth session as sequence setup in lws")
