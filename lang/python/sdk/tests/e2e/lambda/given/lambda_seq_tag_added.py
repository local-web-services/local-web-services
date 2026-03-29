"""Given: a tag has been added to a function"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaTestClient


@given("a tag has been added to a function")
def lambda_seq_tag_added(lws_session):
    LambdaTestClient(lws_session).create_function()
