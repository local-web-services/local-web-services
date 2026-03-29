"""Cognito Lambda trigger event builders."""

from __future__ import annotations

from typing import Any


def build_pre_auth_event(
    username: str,
    user_pool_id: str,
    client_id: str,
) -> dict[str, Any]:
    """Build a Cognito pre-authentication trigger event."""
    return {
        "version": "1",
        "triggerSource": "PreAuthentication_Authentication",
        "region": "us-east-1",
        "userPoolId": user_pool_id,
        "callerContext": {
            "awsSdkVersion": "ldk-local",
            "clientId": client_id,
        },
        "userName": username,
        "request": {
            "userAttributes": {},
        },
        "response": {},
    }


def build_post_confirmation_event(
    username: str,
    sub: str,
    attributes: dict[str, str],
    user_pool_id: str,
    client_id: str,
) -> dict[str, Any]:
    """Build a Cognito post-confirmation trigger event."""
    user_attributes = dict(attributes)
    user_attributes["sub"] = sub
    return {
        "version": "1",
        "triggerSource": "PostConfirmation_ConfirmSignUp",
        "region": "us-east-1",
        "userPoolId": user_pool_id,
        "callerContext": {
            "awsSdkVersion": "ldk-local",
            "clientId": client_id,
        },
        "userName": username,
        "request": {
            "userAttributes": user_attributes,
        },
        "response": {},
    }


def build_pre_signup_event(
    username: str,
    attributes: dict[str, str],
    user_pool_id: str,
    client_id: str,
) -> dict[str, Any]:
    """Build a Cognito pre-signup trigger event."""
    return {
        "version": "1",
        "triggerSource": "PreSignUp_SignUp",
        "region": "us-east-1",
        "userPoolId": user_pool_id,
        "callerContext": {
            "awsSdkVersion": "ldk-local",
            "clientId": client_id,
        },
        "userName": username,
        "request": {
            "userAttributes": dict(attributes),
        },
        "response": {},
    }
