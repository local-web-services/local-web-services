"""Given: a Glacier vault has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsGlacierTestClient


@given("a Glacier vault has been created")
def glacier_vault_has_been_created(lws_session):
    StepfunctionsGlacierTestClient(lws_session).create_vault()
