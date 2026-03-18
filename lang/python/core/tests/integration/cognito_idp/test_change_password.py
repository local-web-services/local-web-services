"""Integration test for Cognito ChangePassword."""

from __future__ import annotations

import httpx


class TestChangePassword:
    async def test_change_password(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        client_id = "test-client"
        username = "change-pw-user"
        password = "Password1!"
        new_password = "NewPassword1!"

        await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.SignUp",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={
                "ClientId": client_id,
                "Username": username,
                "Password": password,
            },
        )

        await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.ConfirmSignUp",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={
                "ClientId": client_id,
                "Username": username,
                "ConfirmationCode": "123456",
            },
        )

        auth_resp = await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.InitiateAuth",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={
                "AuthFlow": "USER_PASSWORD_AUTH",
                "ClientId": client_id,
                "AuthParameters": {
                    "USERNAME": username,
                    "PASSWORD": password,
                },
            },
        )
        access_token = auth_resp.json()["AuthenticationResult"]["AccessToken"]

        # Act
        resp = await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.ChangePassword",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={
                "AccessToken": access_token,
                "PreviousPassword": password,
                "ProposedPassword": new_password,
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
