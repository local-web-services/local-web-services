import type { FastifyInstance, FastifyReply, FastifyRequest } from "fastify";
import type { CognitoProvider } from "./provider.js";

function jsonError(type: string, message: string): string {
  return JSON.stringify({ __type: type, message });
}

function handleError(err: unknown, reply: FastifyReply, action: string): FastifyReply {
  const msg = err instanceof Error ? err.message : String(err);
  for (const code of [
    "ResourceNotFoundException", "UserNotFoundException", "NotAuthorizedException",
    "UsernameExistsException", "InvalidParameterException",
  ]) {
    if (msg.startsWith(code)) return reply.status(400).send(jsonError(code, msg));
  }
  return reply.status(500).send(jsonError("InternalServerError", `${action}: ${msg}`));
}

export async function cognitoAdminPlugin(fastify: FastifyInstance, opts: { provider: CognitoProvider }): Promise<void> {
  const { provider } = opts;

  fastify.post("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const target = (req.headers["x-amz-target"] as string | undefined) ?? "";
    const prefix = "AWSCognitoIdentityProviderService.";
    if (!target.startsWith(prefix)) return reply.status(400).send(jsonError("InvalidAction", `Unknown target: ${target}`));
    const action = target.slice(prefix.length);
    const body = req.body as Record<string, unknown>;
    reply.header("content-type", "application/x-amz-json-1.1");

    try {
      switch (action) {
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
          const attrs = (body["UserAttributes"] as { Name: string; Value: string }[]) ?? [];
          provider.adminUpdateUserAttributes(body["UserPoolId"] as string, body["Username"] as string, attrs);
          return reply.status(200).send(JSON.stringify({}));
        }
        case "ForgotPassword": {
          const result = provider.forgotPassword(body["ClientId"] as string, body["Username"] as string);
          return reply.status(200).send(JSON.stringify(result));
        }
        case "ConfirmForgotPassword": {
          provider.confirmForgotPassword(
            body["ClientId"] as string,
            body["Username"] as string,
            (body["ConfirmationCode"] as string | undefined) ?? "",
            body["Password"] as string,
          );
          return reply.status(200).send(JSON.stringify({}));
        }
        case "ChangePassword": {
          provider.changePassword(
            body["AccessToken"] as string,
            body["PreviousPassword"] as string,
            body["ProposedPassword"] as string,
          );
          return reply.status(200).send(JSON.stringify({}));
        }
        case "RespondToAuthChallenge": {
          const result = await provider.respondToAuthChallenge(
            body["ClientId"] as string,
            body["ChallengeName"] as string,
            (body["ChallengeResponses"] as Record<string, string>) ?? {},
          );
          return reply.status(200).send(JSON.stringify(result));
        }
        case "GlobalSignOut":
          provider.globalSignOut(body["AccessToken"] as string);
          return reply.status(200).send(JSON.stringify({}));
        case "UpdateUserPool":
          provider.updateUserPool(body["UserPoolId"] as string);
          return reply.status(200).send(JSON.stringify({}));
        default:
          return reply.status(400).send(jsonError("InvalidAction", `Unsupported action: ${action}`));
      }
    } catch (err) { return handleError(err, reply, action); }
  });
}
