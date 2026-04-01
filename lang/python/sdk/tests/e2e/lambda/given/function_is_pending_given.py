"""Given: function_is_pending_given"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaTestClient


@given('the "lambda" "function" was "PENDING"')
def function_is_pending_given(lws_session):
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    LambdaTestClient(lws_session).create_function()
