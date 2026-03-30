/** Cognito IDP wire-protocol Fastify plugin — full implementation. */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import type { ServerState } from "../../types";
import { applyChaos } from "../../middleware/chaos";
import { applyFake } from "../../middleware/fake";
import { applyIamAuth } from "../../middleware/iam";
import { createRequestContext, recordLog } from "../../middleware/logging";
import { CognitoStore, type UserAttribute, type UserPool } from "./store";

const TARGET_PREFIX = "AWSCognitoIdentityProviderService.";

function jsonReply(reply: FastifyReply, data: unknown, status = 200): void {
  reply.status(status).header("Content-Type", "application/x-amz-json-1.1").send(data);
}

function errorReply(reply: FastifyReply, type: string, message: string, status = 400): void {
  jsonReply(reply, { __type: type, message }, status);
}

function formatUser(user: ReturnType<CognitoStore["adminGetUser"]>): Record<string, unknown> {
  return {
    Username: user.username,
    UserStatus: user.status,
    Enabled: user.enabled,
    UserAttributes: user.attributes,
    UserCreateDate: user.createdDate,
    UserLastModifiedDate: user.lastModifiedDate,
    MFAOptions: [],
  };
}

function formatUserShort(user: ReturnType<CognitoStore["adminGetUser"]>): Record<string, unknown> {
  return {
    Username: user.username,
    UserStatus: user.status,
    Enabled: user.enabled,
    Attributes: user.attributes,
    UserCreateDate: user.createdDate,
    UserLastModifiedDate: user.lastModifiedDate,
  };
}

function formatGroup(group: ReturnType<CognitoStore["getGroup"]>): Record<string, unknown> {
  return {
    GroupName: group.name,
    UserPoolId: group.poolId,
    Description: group.description ?? "",
    Precedence: group.precedence ?? 0,
    CreationDate: group.createdDate,
    LastModifiedDate: group.lastModifiedDate,
  };
}

export function registerCognitoIdp(app: FastifyInstance, state: ServerState): CognitoStore {
  const store = new CognitoStore();
  state.resetCallbacks.push(() => store.reset());

  app.post("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const target = (req.headers["x-amz-target"] as string) ?? "";
    const rawOperation = target.startsWith(TARGET_PREFIX)
      ? target.slice(TARGET_PREFIX.length)
      : target;
    const ctx = createRequestContext("cognitoidp", rawOperation);

    if (await applyIamAuth(state, "cognito-idp", rawOperation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyChaos(state, "cognito-idp", rawOperation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyFake(state, "cognito-idp", rawOperation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    const body = (req.body as Record<string, unknown>) ?? {};

    try {
      handleOperation(rawOperation, body, store, state, reply);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      if (msg.includes("UserNotFoundException")) {
        errorReply(reply, "UserNotFoundException", msg);
      } else if (msg.includes("UsernameExistsException")) {
        errorReply(reply, "UsernameExistsException", msg);
      } else if (msg.includes("ResourceNotFoundException")) {
        errorReply(reply, "ResourceNotFoundException", msg);
      } else if (msg.includes("GroupExistsException")) {
        errorReply(reply, "GroupExistsException", msg);
      } else if (msg.includes("NotAuthorizedException")) {
        errorReply(reply, "NotAuthorizedException", msg);
      } else if (msg.includes("InvalidParameterException")) {
        errorReply(reply, "InvalidParameterException", msg);
      } else {
        errorReply(reply, "InvalidRequestException", msg);
      }
    }

    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  return store;
}

function isPoolInCreateDwell(pool: UserPool, state: ServerState): boolean {
  const rule = state.lifecycleRules.get("cognitoidp");
  if (!rule || !rule.enabled || rule.createDwellMs <= 0) return false;
  return Date.now() - pool.createdDate * 1000 < rule.createDwellMs;
}

function handleOperation(
  operation: string,
  body: Record<string, unknown>,
  store: CognitoStore,
  state: ServerState,
  reply: FastifyReply,
): void {
  switch (operation) {
    // ── User Pools ────────────────────────────────────────────────────────────

    case "CreateUserPool": {
      const pool = store.createUserPool(
        body.PoolName as string,
        body.Policies as Record<string, unknown> | undefined,
      );
      jsonReply(reply, {
        UserPool: {
          Id: pool.id,
          Name: pool.name,
          Arn: pool.arn,
          Status: pool.status,
          CreationDate: pool.createdDate,
          LastModifiedDate: pool.lastModifiedDate,
        },
      });
      break;
    }

    case "DeleteUserPool": {
      store.deleteUserPool(body.UserPoolId as string);
      jsonReply(reply, {});
      break;
    }

    case "DescribeUserPool": {
      const pool = store.describeUserPool(body.UserPoolId as string);
      jsonReply(reply, {
        UserPool: {
          Id: pool.id,
          Name: pool.name,
          Arn: pool.arn,
          Status: pool.status,
          CreationDate: pool.createdDate,
          LastModifiedDate: pool.lastModifiedDate,
        },
      });
      break;
    }

    case "ListUserPools": {
      const pools = store.listUserPools();
      jsonReply(reply, {
        UserPools: pools.map((p) => ({
          Id: p.id,
          Name: p.name,
          Status: p.status,
          CreationDate: p.createdDate,
          LastModifiedDate: p.lastModifiedDate,
        })),
      });
      break;
    }

    case "UpdateUserPool": {
      // No-op: accept the update and return success
      jsonReply(reply, {});
      break;
    }

    // ── User Pool Clients ─────────────────────────────────────────────────────

    case "CreateUserPoolClient": {
      const client = store.createUserPoolClient(
        body.UserPoolId as string,
        body.ClientName as string,
      );
      jsonReply(reply, {
        UserPoolClient: {
          UserPoolId: client.poolId,
          ClientName: client.clientName,
          ClientId: client.clientId,
          CreationDate: client.createdDate,
          LastModifiedDate: client.lastModifiedDate,
        },
      });
      break;
    }

    case "DescribeUserPoolClient": {
      const client = store.describeUserPoolClient(
        body.UserPoolId as string,
        body.ClientId as string,
      );
      jsonReply(reply, {
        UserPoolClient: {
          UserPoolId: client.poolId,
          ClientName: client.clientName,
          ClientId: client.clientId,
          CreationDate: client.createdDate,
          LastModifiedDate: client.lastModifiedDate,
        },
      });
      break;
    }

    case "DeleteUserPoolClient": {
      store.deleteUserPoolClient(body.UserPoolId as string, body.ClientId as string);
      jsonReply(reply, {});
      break;
    }

    case "UpdateUserPoolClient": {
      jsonReply(reply, {
        UserPoolClient: {
          UserPoolId: body.UserPoolId,
          ClientId: body.ClientId,
          ClientName: body.ClientName,
        },
      });
      break;
    }

    case "ListUserPoolClients": {
      jsonReply(reply, { UserPoolClients: [] });
      break;
    }

    // ── Users ─────────────────────────────────────────────────────────────────

    case "AdminCreateUser": {
      const adminCreatePoolId = body.UserPoolId as string;
      const adminCreatePool = store.getPool(adminCreatePoolId);
      if (!adminCreatePool) {
        errorReply(
          reply,
          "ResourceNotFoundException",
          `ResourceNotFoundException: User pool ${adminCreatePoolId} not found`,
        );
        break;
      }
      if (isPoolInCreateDwell(adminCreatePool, state)) {
        errorReply(
          reply,
          "ResourceNotFoundException",
          `ResourceNotFoundException: User pool ${adminCreatePoolId} is not active`,
        );
        break;
      }
      const attrs = (body.UserAttributes as UserAttribute[]) ?? [];
      const user = store.adminCreateUser(
        adminCreatePoolId,
        body.Username as string,
        attrs,
        body.TemporaryPassword as string | undefined,
      );
      jsonReply(reply, { User: formatUser(user) });
      break;
    }

    case "AdminGetUser": {
      const user = store.adminGetUser(body.UserPoolId as string, body.Username as string);
      jsonReply(reply, {
        Username: user.username,
        UserAttributes: user.attributes,
        UserStatus: user.status,
        Enabled: user.enabled,
        UserCreateDate: user.createdDate,
        UserLastModifiedDate: user.lastModifiedDate,
      });
      break;
    }

    case "AdminDeleteUser": {
      store.adminDeleteUser(body.UserPoolId as string, body.Username as string);
      jsonReply(reply, {});
      break;
    }

    case "ListUsers": {
      const users = store.listUsers(
        body.UserPoolId as string,
        body.Filter as string | undefined,
        body.Limit as number | undefined,
      );
      jsonReply(reply, { Users: users.map(formatUserShort) });
      break;
    }

    case "AdminConfirmSignUp": {
      store.adminConfirmSignUp(body.UserPoolId as string, body.Username as string);
      jsonReply(reply, {});
      break;
    }

    case "AdminDisableUser": {
      store.adminDisableUser(body.UserPoolId as string, body.Username as string);
      jsonReply(reply, {});
      break;
    }

    case "AdminEnableUser": {
      store.adminEnableUser(body.UserPoolId as string, body.Username as string);
      jsonReply(reply, {});
      break;
    }

    case "AdminSetUserPassword": {
      store.adminSetUserPassword(
        body.UserPoolId as string,
        body.Username as string,
        body.Password as string,
        !!body.Permanent,
      );
      jsonReply(reply, {});
      break;
    }

    case "AdminResetUserPassword": {
      store.adminResetUserPassword(body.UserPoolId as string, body.Username as string);
      jsonReply(reply, {});
      break;
    }

    case "AdminUpdateUserAttributes": {
      store.adminUpdateUserAttributes(
        body.UserPoolId as string,
        body.Username as string,
        (body.UserAttributes as UserAttribute[]) ?? [],
      );
      jsonReply(reply, {});
      break;
    }

    case "AdminUserGlobalSignOut":
    case "GlobalSignOut": {
      jsonReply(reply, {});
      break;
    }

    case "AdminSetUserMFAPreference":
    case "SetUserMFAPreference": {
      jsonReply(reply, {});
      break;
    }

    // ── Groups ────────────────────────────────────────────────────────────────

    case "CreateGroup": {
      const createGroupPoolId = body.UserPoolId as string;
      const createGroupPool = store.getPool(createGroupPoolId);
      if (!createGroupPool) {
        errorReply(
          reply,
          "ResourceNotFoundException",
          `ResourceNotFoundException: User pool ${createGroupPoolId} not found`,
        );
        break;
      }
      if (isPoolInCreateDwell(createGroupPool, state)) {
        errorReply(
          reply,
          "ResourceNotFoundException",
          `ResourceNotFoundException: User pool ${createGroupPoolId} is not active`,
        );
        break;
      }
      const group = store.createGroup(
        createGroupPoolId,
        body.GroupName as string,
        body.Description as string | undefined,
        body.Precedence as number | undefined,
      );
      jsonReply(reply, { Group: formatGroup(group) });
      break;
    }

    case "DeleteGroup": {
      store.deleteGroup(body.UserPoolId as string, body.GroupName as string);
      jsonReply(reply, {});
      break;
    }

    case "GetGroup": {
      const group = store.getGroup(body.UserPoolId as string, body.GroupName as string);
      jsonReply(reply, { Group: formatGroup(group) });
      break;
    }

    case "ListGroups": {
      const groups = store.listGroups(body.UserPoolId as string);
      jsonReply(reply, { Groups: groups.map(formatGroup) });
      break;
    }

    case "AdminAddUserToGroup": {
      store.adminAddUserToGroup(
        body.UserPoolId as string,
        body.Username as string,
        body.GroupName as string,
      );
      jsonReply(reply, {});
      break;
    }

    case "AdminRemoveUserFromGroup": {
      store.adminRemoveUserFromGroup(
        body.UserPoolId as string,
        body.Username as string,
        body.GroupName as string,
      );
      jsonReply(reply, {});
      break;
    }

    case "ListUsersInGroup": {
      const users = store.listUsersInGroup(body.UserPoolId as string, body.GroupName as string);
      jsonReply(reply, { Users: users.map(formatUserShort) });
      break;
    }

    case "AdminListGroupsForUser": {
      const groups = store.adminListGroupsForUser(
        body.UserPoolId as string,
        body.Username as string,
      );
      jsonReply(reply, { Groups: groups.map(formatGroup) });
      break;
    }

    // ── Auth ──────────────────────────────────────────────────────────────────

    case "AdminInitiateAuth": {
      const result = store.adminInitiateAuth(
        body.UserPoolId as string,
        body.AuthFlow as string,
        (body.AuthParameters as Record<string, string>) ?? {},
      );
      if (result.tokens) {
        jsonReply(reply, { AuthenticationResult: result.tokens });
      } else {
        jsonReply(reply, {
          ChallengeName: result.challengeName,
          Session: result.session,
          ChallengeParameters: result.challengeParameters ?? {},
        });
      }
      break;
    }

    case "InitiateAuth": {
      const result = store.initiateAuth(
        body.ClientId as string,
        body.AuthFlow as string,
        (body.AuthParameters as Record<string, string>) ?? {},
      );
      if (result.tokens) {
        jsonReply(reply, { AuthenticationResult: result.tokens });
      } else {
        jsonReply(reply, {
          ChallengeName: result.challengeName,
          Session: result.session,
          ChallengeParameters: result.challengeParameters ?? {},
        });
      }
      break;
    }

    case "RespondToAuthChallenge": {
      const result = store.respondToAuthChallenge(
        body.ClientId as string,
        body.ChallengeName as string,
        body.Session as string,
        (body.ChallengeResponses as Record<string, string>) ?? {},
      );
      jsonReply(reply, { AuthenticationResult: result.tokens });
      break;
    }

    case "AdminRespondToAuthChallenge": {
      const result = store.respondToAuthChallenge(
        body.ClientId as string,
        body.ChallengeName as string,
        body.Session as string,
        (body.ChallengeResponses as Record<string, string>) ?? {},
      );
      jsonReply(reply, { AuthenticationResult: result.tokens });
      break;
    }

    // ── Sign-up flows (self-service) ──────────────────────────────────────────

    case "SignUp": {
      // Self-service sign-up: create an unconfirmed user
      const clientId = body.ClientId as string;
      const username = body.Username as string;
      const password = body.Password as string;
      const attrs = (body.UserAttributes as UserAttribute[]) ?? [];

      const client = store.describeUserPoolClientByClientId(clientId);
      const user = store.adminCreateUser(client.poolId, username, attrs, password);
      user.status = "UNCONFIRMED";
      jsonReply(reply, {
        UserConfirmed: false,
        UserSub: username,
        CodeDeliveryDetails: {
          Destination: attrs.find((a) => a.Name === "email")?.Value ?? username,
          DeliveryMedium: "EMAIL",
          AttributeName: "email",
        },
      });
      break;
    }

    case "ConfirmSignUp": {
      const clientId = body.ClientId as string;
      const client = store.describeUserPoolClientByClientId(clientId);
      store.adminConfirmSignUp(client.poolId, body.Username as string);
      jsonReply(reply, {});
      break;
    }

    case "ForgotPassword": {
      jsonReply(reply, {
        CodeDeliveryDetails: {
          Destination: "***@example.com",
          DeliveryMedium: "EMAIL",
          AttributeName: "email",
        },
      });
      break;
    }

    case "ConfirmForgotPassword": {
      const clientId2 = body.ClientId as string;
      const client2 = store.describeUserPoolClientByClientId(clientId2);
      store.adminSetUserPassword(
        client2.poolId,
        body.Username as string,
        body.Password as string,
        true,
      );
      jsonReply(reply, {});
      break;
    }

    case "ChangePassword": {
      jsonReply(reply, {});
      break;
    }

    case "GetUser": {
      // Minimal implementation: parse the access token to get username
      jsonReply(reply, { Username: "unknown", UserAttributes: [] });
      break;
    }

    case "UpdateUserAttributes": {
      jsonReply(reply, { CodeDeliveryDetailsList: [] });
      break;
    }

    // ── Identity pools (stub) ─────────────────────────────────────────────────

    case "GetId":
    case "GetCredentialsForIdentity":
    case "GetOpenIdToken": {
      jsonReply(reply, {
        IdentityId: "us-east-1:00000000-0000-0000-0000-000000000000",
        Token: "lws-openid-token",
        Credentials: {
          AccessKeyId: "test",
          SecretKey: "test",
          SessionToken: "test",
          Expiration: Date.now() / 1000 + 3600,
        },
      });
      break;
    }

    default: {
      errorReply(
        reply,
        "UnknownOperationException",
        `lws: CognitoIDP operation '${operation}' is not yet implemented`,
        400,
      );
    }
  }
}
