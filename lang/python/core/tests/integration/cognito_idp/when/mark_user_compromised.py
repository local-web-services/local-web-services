"""When: a "cognito" "user" is marked as compromised"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "cognito" "user" is marked as compromised')
def mark_user_compromised(client: TestClient, world):
    pytest.skip(
        "AdminUserGlobalSignOut (mark-compromised) is not yet implemented "
        "in the lws Cognito provider."
    )
