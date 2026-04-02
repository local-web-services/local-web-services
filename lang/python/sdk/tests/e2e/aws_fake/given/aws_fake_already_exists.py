"""Given: the "aws fake" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import AwsFakeTestClient


@given('the "aws fake" already existed')
def aws_fake_already_exists(lws_session):
    AwsFakeTestClient(lws_session).create()
