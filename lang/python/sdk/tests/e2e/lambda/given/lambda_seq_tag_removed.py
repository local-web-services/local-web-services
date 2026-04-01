"""Given: a tag is removed from a "lambda" "function" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaTestClient


@given('a tag is removed from a "lambda" "function"')
def lambda_seq_tag_removed(lws_session):
    LambdaTestClient(lws_session).create_function()
