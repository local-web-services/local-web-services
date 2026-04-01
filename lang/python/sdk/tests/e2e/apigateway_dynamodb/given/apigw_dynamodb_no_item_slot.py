"""Given: no item slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("no item slot is available")
def apigw_dynamodb_no_item_slot(lws_session):
    lws_session.capacity("dynamodb").exhaust().apply()
