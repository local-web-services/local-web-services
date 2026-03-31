"""Given: the "api gateway" "deployment" slot is already in use"""

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "deployment" slot is already in use')
def deployment_slot_already_in_use(lws_session):
    lws_session.capacity("apigateway").exhaust().apply()
