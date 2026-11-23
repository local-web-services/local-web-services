import type { FastifyInstance, FastifyReply, FastifyRequest } from "fastify";
import type { CognitoProvider } from "./provider.js";

export interface CognitoRoutesOptions {
  provider: CognitoProvider;
}

function jsonError(type: string, message: string): string {
  return JSON.stringify({ __type: type, message });
}

export async function cognitoRoutesPlugin(
  fastify: FastifyInstance,
  opts: CognitoRoutesOptions,
): Promise<void> {
  const { provider } = opts;

  fastify.addContentTypeParser(
    "application/x-amz-json-1.1",
    { parseAs: "string" },
    (_req, body, done) => {
      try {
        done(null, JSON.parse(body as string));
      } catch (err) {
        done(err as Error);
      }
    },
  );

  fastify.post("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const target = (req.headers["x-amz-target"] as string | undefined) ?? "";
    const prefix = "AWSCognitoIdentityProviderService.";
    if (!target.startsWith(prefix)) {
      return reply.status(400).header("content-type", "application/x-amz-json-1.1")
        .send(jsonError("InvalidAction", `Unknown target: ${target}`));
    }
    const action = target.slice(prefix.length);
    const body = req.body as Record<string, unknown>;
    reply.header("content-type", "application/x-amz-json-1.1");

    try {
      switch (action) {
        case "CreateUserPool": {
          const name = body["PoolName"] as string;
          const result = await provider.createUserPool(name);
          return reply.status(200).send(JSON.stringify(result));
        }
        case "DeleteUserPool": {
          const poolId = body["UserPoolId"] as string;
          provider.deleteUserPool(poolId);
          return reply.status(200).send(JSON.stringify({}));
        }
        case "ListUserPools": {
          const result = provider.listUserPools();
          return reply.status(200).send(JSON.stringify(result));
        }
        case "DescribeUserPool": {
          const poolId = body["UserPoolId"] as string;
          const result = provider.describeUserPool(poolId);
          return reply.status(200).send(JSON.stringify(result));
        }
        case "CreateUserPoolClient": {
          const poolId = body["UserPoolId"] as string;
          const clientName = body["ClientName"] as string;
          const result = provider.createUserPoolClient(poolId, clientName);
          return reply.status(200).send(JSON.stringify(result));
        }
        case "DescribeUserPoolClient": {
          const poolId = body["UserPoolId"] as string;
          const clientId = body["ClientId"] as string;
          const result = provider.describeUserPoolClient(poolId, clientId);
          return reply.status(200).send(JSON.stringify(result));
        }
        case "DeleteUserPoolClient": {
          const poolId = body["UserPoolId"] as string;
          const clientId = body["ClientId"] as string;
          provider.deleteUserPoolClient(poolId, clientId);
          return reply.status(200).send(JSON.stringify({}));
        }
        case "ListUserPoolClients": {
          const poolId = body["UserPoolId"] as string;
          const result = provider.listUserPoolClients(poolId);
          return reply.status(200).send(JSON.stringify(result));
        }
        case "AdminCreateUser": {
          const poolId = body["UserPoolId"] as string;
          const username = body["Username"] as string;
          const tempPassword = body["TemporaryPassword"] as string | undefined;
          const attrs = (body["UserAttributes"] as { Name: string; Value: string }[] | undefined) ?? [];
          const result = provider.adminCreateUser(poolId, username, tempPassword, attrs);
          return reply.status(200).send(JSON.stringify(result));
        }
        case "AdminDeleteUser": {
          const poolId = body["UserPoolId"] as string;
          const username = body["Username"] as string;
          provider.adminDeleteUser(poolId, username);
          return reply.status(200).send(JSON.stringify({}));
        }
        case "AdminGetUser": {
          const poolId = body["UserPoolId"] as string;
          const username = body["Username"] as string;
          const user = provider.adminGetUser(poolId, username);
          return reply.status(200).send(JSON.stringify(user));
        }
        case "AdminSetUserPassword": {
          const poolId = body["UserPoolId"] as string;
          const username = body["Username"] as string;
          const password = body["Password"] as string;
          provider.adminSetUserPassword(poolId, username, password);
          return reply.status(200).send(JSON.stringify({}));
        }
        case "ListUsers": {
          const poolId = body["UserPoolId"] as string;
          const result = provider.listUsers(poolId);
          return reply.status(200).send(JSON.stringify(result));
        }
        case "InitiateAuth": {
          const clientId = body["ClientId"] as string;
          const authFlow = body["AuthFlow"] as string;
          const authParams = (body["AuthParameters"] as Record<string, string>) ?? {};
          const result = await provider.initiateAuth(clientId, authFlow, authParams);
          return reply.status(200).send(JSON.stringify(result));
        }
        case "AdminInitiateAuth": {
          const poolId = body["UserPoolId"] as string;
          const clientId = body["ClientId"] as string;
          const authFlow = body["AuthFlow"] as string;
          const authParams = (body["AuthParameters"] as Record<string, string>) ?? {};
          const result = await provider.initiateAuth(clientId, authFlow, authParams, poolId);
          return reply.status(200).send(JSON.stringify(result));
        }
        case "GetUser": {
          const accessToken = body["AccessToken"] as string;
          const result = provider.getUser(accessToken);
          return reply.status(200).send(JSON.stringify(result));
        }
        case "SignUp": {
          const clientId = body["ClientId"] as string;
          const username = body["Username"] as string;
          const password = body["Password"] as string;
          const attrs = (body["UserAttributes"] as { Name: string; Value: string }[] | undefined) ?? [];
          const result = provider.signUp(clientId, username, password, attrs);
          return reply.status(200).send(JSON.stringify(result));
        }
        case "ConfirmSignUp": {
          const clientId = body["ClientId"] as string;
          const username = body["Username"] as string;
          const code = (body["ConfirmationCode"] as string | undefined) ?? "";
          provider.confirmSignUp(clientId, username, code);
          return reply.status(200).send(JSON.stringify({}));
        }
        case "UpdateUserPool":
          provider.updateUserPool(body["UserPoolId"] as string);
          return reply.status(200).send(JSON.stringify({}));
        case "CreateGroup": {
          const result = provider.createGroup(body["UserPoolId"] as string, body["GroupName"] as string, body["Description"] as string | undefined);
          return reply.status(200).send(JSON.stringify(result));
        }
        case "DeleteGroup":
          provider.deleteGroup(body["UserPoolId"] as string, body["GroupName"] as string);
          return reply.status(200).send(JSON.stringify({}));
        case "ListGroups":
          return reply.status(200).send(JSON.stringify(provider.listGroups(body["UserPoolId"] as string)));
        case "AdminAddUserToGroup":
          provider.adminAddUserToGroup(body["UserPoolId"] as string, body["Username"] as string, body["GroupName"] as string);
          return reply.status(200).send(JSON.stringify({}));
        case "AdminRemoveUserFromGroup":
          provider.adminRemoveUserFromGroup(body["UserPoolId"] as string, body["Username"] as string, body["GroupName"] as string);
          return reply.status(200).send(JSON.stringify({}));
        case "ListUsersInGroup":
          return reply.status(200).send(JSON.stringify(provider.listUsersInGroup(body["UserPoolId"] as string, body["GroupName"] as string)));
        case "AdminDisableUser":
          provider.adminDisableUser(body["UserPoolId"] as string, body["Username"] as string);
          return reply.status(200).send(JSON.stringify({}));
        case "AdminEnableUser":
          provider.adminEnableUser(body["UserPoolId"] as string, body["Username"] as string);
          return reply.status(200).send(JSON.stringify({}));
        case "AdminConfirmSignUp":
          provider.adminConfirmSignUp(body["UserPoolId"] as string, body["Username"] as string);
          return reply.status(200).send(JSON.stringify({}));
        case "AdminResetUserPassword":
          provider.adminResetUserPassword(body["UserPoolId"] as string, body["Username"] as string);
          return reply.status(200).send(JSON.stringify({}));
        case "AdminUpdateUserAttributes": {
          const attrs = (body["UserAttributes"] as { Name: string; Value: string }[] | undefined) ?? [];
          provider.adminUpdateUserAttributes(body["UserPoolId"] as string, body["Username"] as string, attrs);
          return reply.status(200).send(JSON.stringify({}));
        }
        case "ForgotPassword":
          return reply.status(200).send(JSON.stringify(provider.forgotPassword(body["ClientId"] as string, body["Username"] as string)));
        case "ConfirmForgotPassword":
          provider.confirmForgotPassword(body["ClientId"] as string, body["Username"] as string, (body["ConfirmationCode"] as string | undefined) ?? "", body["Password"] as string);
          return reply.status(200).send(JSON.stringify({}));
        case "ChangePassword":
          provider.changePassword(body["AccessToken"] as string, body["PreviousPassword"] as string, body["ProposedPassword"] as string);
          return reply.status(200).send(JSON.stringify({}));
        case "RespondToAuthChallenge": {
          const result = await provider.respondToAuthChallenge(body["ClientId"] as string, body["ChallengeName"] as string, (body["ChallengeResponses"] as Record<string, string>) ?? {});
          return reply.status(200).send(JSON.stringify(result));
        }
        case "GlobalSignOut":
          provider.globalSignOut(body["AccessToken"] as string);
          return reply.status(200).send(JSON.stringify({}));
        default:
          return reply.status(400).send(jsonError("InvalidAction", `Unsupported action: ${action}`));
      }
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      for (const code of [
        "ResourceNotFoundException",
        "UserNotFoundException",
        "NotAuthorizedException",
        "UsernameExistsException",
        "InvalidParameterException",
      ]) {
        if (msg.startsWith(code)) return reply.status(400).send(jsonError(code, msg));
      }
      return reply.status(500).send(jsonError("InternalServerError", msg));
    }
  });
}
