import type { FastifyInstance, FastifyReply, FastifyRequest } from "fastify";
import type { CognitoProvider } from "./provider.js";

function jsonError(type: string, message: string): string {
  return JSON.stringify({ __type: type, message });
}

function handleError(err: unknown, reply: FastifyReply, action: string): FastifyReply {
  const msg = err instanceof Error ? err.message : String(err);
  for (const code of ["ResourceNotFoundException", "UserNotFoundException", "InvalidParameterException"]) {
    if (msg.startsWith(code)) return reply.status(400).send(jsonError(code, msg));
  }
  return reply.status(500).send(jsonError("InternalServerError", `${action}: ${msg}`));
}

export async function cognitoGroupsPlugin(fastify: FastifyInstance, opts: { provider: CognitoProvider }): Promise<void> {
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
        case "CreateGroup": {
          const poolId = body["UserPoolId"] as string;
          const groupName = body["GroupName"] as string;
          const description = body["Description"] as string | undefined;
          return reply.status(200).send(JSON.stringify(provider.createGroup(poolId, groupName, description)));
        }
        case "DeleteGroup": {
          provider.deleteGroup(body["UserPoolId"] as string, body["GroupName"] as string);
          return reply.status(200).send(JSON.stringify({}));
        }
        case "ListGroups": {
          return reply.status(200).send(JSON.stringify(provider.listGroups(body["UserPoolId"] as string)));
        }
        case "AdminAddUserToGroup": {
          provider.adminAddUserToGroup(body["UserPoolId"] as string, body["Username"] as string, body["GroupName"] as string);
          return reply.status(200).send(JSON.stringify({}));
        }
        case "AdminRemoveUserFromGroup": {
          provider.adminRemoveUserFromGroup(body["UserPoolId"] as string, body["Username"] as string, body["GroupName"] as string);
          return reply.status(200).send(JSON.stringify({}));
        }
        case "ListUsersInGroup": {
          return reply.status(200).send(JSON.stringify(provider.listUsersInGroup(body["UserPoolId"] as string, body["GroupName"] as string)));
        }
        default:
          return reply.status(400).send(jsonError("InvalidAction", `Unsupported action: ${action}`));
      }
    } catch (err) { return handleError(err, reply, action); }
  });
}
