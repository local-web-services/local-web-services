"""When: a verification code delivery fails for an unconfirmed "cognito" "user" """

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a verification code delivery fails for an unconfirmed "cognito" "user"')
def verification_code_delivery_failure(client: TestClient, world):
    pytest.skip("ResendConfirmationCode is not yet implemented in the lws Cognito provider.")
