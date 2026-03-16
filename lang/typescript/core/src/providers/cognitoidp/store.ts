/** Cognito IDP in-memory store. */

import { v4 as uuidv4 } from "uuid";

const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";

export type UserStatus =
  | "UNCONFIRMED"
  | "CONFIRMED"
  | "FORCE_CHANGE_PASSWORD"
  | "DISABLED"
  | "COMPROMISED";

export interface UserAttribute {
  Name: string;
  Value: string;
}

export interface CognitoUser {
  username: string;
  status: UserStatus;
  enabled: boolean;
  password: string;
  temporaryPassword?: string;
  attributes: UserAttribute[];
  createdDate: number;
  lastModifiedDate: number;
  mfaEnabled: boolean;
}

export interface CognitoGroup {
  name: string;
  poolId: string;
  description?: string;
  precedence?: number;
  createdDate: number;
  lastModifiedDate: number;
}

export interface UserPool {
  id: string;
  name: string;
  arn: string;
  status: string;
  createdDate: number;
  lastModifiedDate: number;
  policies?: Record<string, unknown>;
}

export interface UserPoolClient {
  clientId: string;
  clientName: string;
  poolId: string;
  clientSecret?: string;
  createdDate: number;
  lastModifiedDate: number;
}

export interface AuthSession {
  poolId: string;
  username: string;
  challenge: string;
  session: string;
  createdAt: number;
}

function base64url(data: string): string {
  return Buffer.from(data).toString("base64url");
}

function makeJwt(header: object, payload: object): string {
  const h = base64url(JSON.stringify(header));
  const p = base64url(JSON.stringify(payload));
  // dummy signature for local test use only
  const sig = base64url("lws-local-test-sig");
  return `${h}.${p}.${sig}`;
}

export function makeTokens(
  poolId: string,
  username: string,
  attributes: UserAttribute[]
): { IdToken: string; AccessToken: string; RefreshToken: string; ExpiresIn: number; TokenType: string } {
  const now = Math.floor(Date.now() / 1000);
  const exp = now + 3600;
  const sub = uuidv4();

  const attrMap: Record<string, string> = {};
  for (const a of attributes) {
    attrMap[a.Name] = a.Value;
  }

  const idToken = makeJwt(
    { alg: "RS256", kid: "lws-local", typ: "JWT" },
    {
      sub,
      iss: `https://cognito-idp.${REGION}.amazonaws.com/${poolId}`,
      aud: "lws-local-client",
      token_use: "id",
      cognito_username: username,
      email: attrMap["email"] ?? `${username}@example.com`,
      iat: now,
      exp,
    }
  );

  const accessToken = makeJwt(
    { alg: "RS256", kid: "lws-local", typ: "JWT" },
    {
      sub,
      iss: `https://cognito-idp.${REGION}.amazonaws.com/${poolId}`,
      token_use: "access",
      username,
      scope: "aws.cognito.signin.user.admin",
      iat: now,
      exp,
    }
  );

  const refreshToken = `lws-refresh-${uuidv4()}`;

  return {
    IdToken: idToken,
    AccessToken: accessToken,
    RefreshToken: refreshToken,
    ExpiresIn: 3600,
    TokenType: "Bearer",
  };
}

export class CognitoStore {
  private pools: Map<string, UserPool> = new Map();
  private poolsByName: Map<string, string> = new Map(); // name → id
  private clients: Map<string, UserPoolClient> = new Map(); // clientId → client
  private users: Map<string, Map<string, CognitoUser>> = new Map(); // poolId → username → user
  private groups: Map<string, Map<string, CognitoGroup>> = new Map(); // poolId → groupName → group
  private groupMembers: Map<string, Map<string, Set<string>>> = new Map(); // poolId → groupName → usernames
  private authSessions: Map<string, AuthSession> = new Map(); // session token → session

  reset(): void {
    this.pools.clear();
    this.poolsByName.clear();
    this.clients.clear();
    this.users.clear();
    this.groups.clear();
    this.groupMembers.clear();
    this.authSessions.clear();
  }

  // ── User Pools ──────────────────────────────────────────────────────────────

  createUserPool(name: string, policies?: Record<string, unknown>): UserPool {
    const id = `${REGION}_${uuidv4().replace(/-/g, "").slice(0, 9)}`;
    const now = Date.now() / 1000;
    const pool: UserPool = {
      id,
      name,
      arn: `arn:aws:cognito-idp:${REGION}:${ACCOUNT_ID}:userpool/${id}`,
      status: "Active",
      createdDate: now,
      lastModifiedDate: now,
      policies,
    };
    this.pools.set(id, pool);
    this.poolsByName.set(name, id);
    this.users.set(id, new Map());
    this.groups.set(id, new Map());
    this.groupMembers.set(id, new Map());
    return pool;
  }

  getPool(userPoolId: string): UserPool | undefined {
    return this.pools.get(userPoolId);
  }

  deleteUserPool(userPoolId: string): void {
    const pool = this.pools.get(userPoolId);
    if (!pool) throw new Error(`ResourceNotFoundException: User pool ${userPoolId} not found`);
    this.pools.delete(userPoolId);
    this.poolsByName.delete(pool.name);
    this.users.delete(userPoolId);
    this.groups.delete(userPoolId);
    this.groupMembers.delete(userPoolId);
  }

  listUserPools(): UserPool[] {
    return Array.from(this.pools.values());
  }

  describeUserPool(userPoolId: string): UserPool {
    const pool = this.pools.get(userPoolId);
    if (!pool) throw new Error(`ResourceNotFoundException: User pool ${userPoolId} not found`);
    return pool;
  }

  // ── User Pool Clients ───────────────────────────────────────────────────────

  createUserPoolClient(poolId: string, clientName: string): UserPoolClient {
    this.describeUserPool(poolId);
    const clientId = uuidv4().replace(/-/g, "").slice(0, 26);
    const now = Date.now() / 1000;
    const client: UserPoolClient = {
      clientId,
      clientName,
      poolId,
      createdDate: now,
      lastModifiedDate: now,
    };
    this.clients.set(clientId, client);
    return client;
  }

  describeUserPoolClient(userPoolId: string, clientId: string): UserPoolClient {
    const client = this.clients.get(clientId);
    if (!client || client.poolId !== userPoolId) {
      throw new Error(`ResourceNotFoundException: Client ${clientId} not found in pool ${userPoolId}`);
    }
    return client;
  }

  deleteUserPoolClient(userPoolId: string, clientId: string): void {
    const client = this.clients.get(clientId);
    if (client && client.poolId === userPoolId) {
      this.clients.delete(clientId);
    }
  }

  describeUserPoolClientByClientId(clientId: string): UserPoolClient {
    const client = this.clients.get(clientId);
    if (!client) throw new Error(`ResourceNotFoundException: Client ${clientId} not found`);
    return client;
  }

  // ── Users ───────────────────────────────────────────────────────────────────

  private poolUsers(poolId: string): Map<string, CognitoUser> {
    const m = this.users.get(poolId);
    if (!m) throw new Error(`ResourceNotFoundException: User pool ${poolId} not found`);
    return m;
  }

  adminCreateUser(
    poolId: string,
    username: string,
    attributes: UserAttribute[],
    temporaryPassword?: string
  ): CognitoUser {
    const poolUsers = this.poolUsers(poolId);
    if (poolUsers.has(username)) {
      throw new Error(`UsernameExistsException: User ${username} already exists`);
    }
    const now = Date.now() / 1000;
    const user: CognitoUser = {
      username,
      status: temporaryPassword ? "FORCE_CHANGE_PASSWORD" : "UNCONFIRMED",
      enabled: true,
      password: temporaryPassword ?? "",
      temporaryPassword,
      attributes,
      createdDate: now,
      lastModifiedDate: now,
      mfaEnabled: false,
    };
    poolUsers.set(username, user);
    return user;
  }

  adminGetUser(poolId: string, username: string): CognitoUser {
    const user = this.poolUsers(poolId).get(username);
    if (!user) throw new Error(`UserNotFoundException: User ${username} not found`);
    return user;
  }

  adminDeleteUser(poolId: string, username: string): void {
    const poolUsers = this.poolUsers(poolId);
    if (!poolUsers.has(username)) throw new Error(`UserNotFoundException: User ${username} not found`);
    poolUsers.delete(username);
  }

  listUsers(poolId: string, filter?: string, limit?: number): CognitoUser[] {
    const poolUsers = this.poolUsers(poolId);
    let users = Array.from(poolUsers.values());
    if (filter) {
      // Simple attribute filter: e.g. `email = "user@example.com"`
      const match = filter.match(/^(\w+)\s*=\s*"(.*)"\s*$/);
      if (match) {
        const [, attrName, attrValue] = match;
        users = users.filter((u) =>
          u.attributes.some((a) => a.Name === attrName && a.Value === attrValue)
        );
      }
    }
    if (limit !== undefined) users = users.slice(0, limit);
    return users;
  }

  adminConfirmSignUp(poolId: string, username: string): void {
    const user = this.adminGetUser(poolId, username);
    user.status = "CONFIRMED";
    user.lastModifiedDate = Date.now() / 1000;
  }

  adminDisableUser(poolId: string, username: string): void {
    const user = this.adminGetUser(poolId, username);
    user.enabled = false;
    user.lastModifiedDate = Date.now() / 1000;
  }

  adminEnableUser(poolId: string, username: string): void {
    const user = this.adminGetUser(poolId, username);
    user.enabled = true;
    user.lastModifiedDate = Date.now() / 1000;
  }

  adminSetUserPassword(poolId: string, username: string, password: string, permanent: boolean): void {
    const user = this.adminGetUser(poolId, username);
    user.password = password;
    if (permanent) {
      user.status = "CONFIRMED";
      user.temporaryPassword = undefined;
    } else {
      user.temporaryPassword = password;
      user.status = "FORCE_CHANGE_PASSWORD";
    }
    user.lastModifiedDate = Date.now() / 1000;
  }

  adminResetUserPassword(poolId: string, username: string): void {
    const user = this.adminGetUser(poolId, username);
    user.status = "FORCE_CHANGE_PASSWORD";
    user.temporaryPassword = undefined;
    user.lastModifiedDate = Date.now() / 1000;
  }

  adminUpdateUserAttributes(poolId: string, username: string, attributes: UserAttribute[]): void {
    const user = this.adminGetUser(poolId, username);
    for (const attr of attributes) {
      const existing = user.attributes.find((a) => a.Name === attr.Name);
      if (existing) {
        existing.Value = attr.Value;
      } else {
        user.attributes.push(attr);
      }
    }
    user.lastModifiedDate = Date.now() / 1000;
  }

  markUserCompromised(poolId: string, username: string): void {
    const user = this.adminGetUser(poolId, username);
    user.status = "COMPROMISED";
    user.lastModifiedDate = Date.now() / 1000;
  }

  // ── Groups ──────────────────────────────────────────────────────────────────

  private poolGroups(poolId: string): Map<string, CognitoGroup> {
    const m = this.groups.get(poolId);
    if (!m) throw new Error(`ResourceNotFoundException: User pool ${poolId} not found`);
    return m;
  }

  private poolGroupMembers(poolId: string): Map<string, Set<string>> {
    const m = this.groupMembers.get(poolId);
    if (!m) throw new Error(`ResourceNotFoundException: User pool ${poolId} not found`);
    return m;
  }

  createGroup(
    poolId: string,
    groupName: string,
    description?: string,
    precedence?: number
  ): CognitoGroup {
    const groups = this.poolGroups(poolId);
    if (groups.has(groupName)) throw new Error(`GroupExistsException: Group ${groupName} already exists`);
    const now = Date.now() / 1000;
    const group: CognitoGroup = {
      name: groupName,
      poolId,
      description,
      precedence,
      createdDate: now,
      lastModifiedDate: now,
    };
    groups.set(groupName, group);
    this.poolGroupMembers(poolId).set(groupName, new Set());
    return group;
  }

  getGroup(poolId: string, groupName: string): CognitoGroup {
    const group = this.poolGroups(poolId).get(groupName);
    if (!group) throw new Error(`ResourceNotFoundException: Group ${groupName} not found`);
    return group;
  }

  deleteGroup(poolId: string, groupName: string): void {
    const groups = this.poolGroups(poolId);
    if (!groups.has(groupName)) throw new Error(`ResourceNotFoundException: Group ${groupName} not found`);
    groups.delete(groupName);
    this.poolGroupMembers(poolId).delete(groupName);
  }

  listGroups(poolId: string): CognitoGroup[] {
    return Array.from(this.poolGroups(poolId).values());
  }

  adminAddUserToGroup(poolId: string, username: string, groupName: string): void {
    this.adminGetUser(poolId, username);
    this.getGroup(poolId, groupName);
    this.poolGroupMembers(poolId).get(groupName)!.add(username);
  }

  adminRemoveUserFromGroup(poolId: string, username: string, groupName: string): void {
    this.poolGroupMembers(poolId).get(groupName)?.delete(username);
  }

  listUsersInGroup(poolId: string, groupName: string): CognitoUser[] {
    this.getGroup(poolId, groupName);
    const members = this.poolGroupMembers(poolId).get(groupName) ?? new Set();
    const poolUsers = this.poolUsers(poolId);
    return Array.from(members)
      .map((u) => poolUsers.get(u))
      .filter((u): u is CognitoUser => u !== undefined);
  }

  adminListGroupsForUser(poolId: string, username: string): CognitoGroup[] {
    this.adminGetUser(poolId, username);
    const poolGroups = this.poolGroups(poolId);
    const groupMembers = this.poolGroupMembers(poolId);
    const result: CognitoGroup[] = [];
    for (const [groupName, members] of groupMembers.entries()) {
      if (members.has(username)) {
        const g = poolGroups.get(groupName);
        if (g) result.push(g);
      }
    }
    return result;
  }

  // ── Auth ────────────────────────────────────────────────────────────────────

  adminInitiateAuth(
    poolId: string,
    authFlow: string,
    authParameters: Record<string, string>
  ): { tokens?: ReturnType<typeof makeTokens>; challengeName?: string; session?: string; challengeParameters?: Record<string, string> } {
    this.describeUserPool(poolId);
    if (authFlow === "ADMIN_USER_PASSWORD_AUTH") {
      const username = authParameters["USERNAME"];
      const password = authParameters["PASSWORD"];
      const user = this.adminGetUser(poolId, username);
      if (!user.enabled) throw new Error(`NotAuthorizedException: User is disabled`);
      if (user.status === "COMPROMISED") throw new Error(`UserNotFoundException: User not found`);
      if (user.password !== password && user.temporaryPassword !== password) {
        throw new Error(`NotAuthorizedException: Incorrect username or password`);
      }
      if (user.status === "FORCE_CHANGE_PASSWORD") {
        const session = `lws-session-${uuidv4()}`;
        this.authSessions.set(session, {
          poolId,
          username,
          challenge: "NEW_PASSWORD_REQUIRED",
          session,
          createdAt: Date.now() / 1000,
        });
        return {
          challengeName: "NEW_PASSWORD_REQUIRED",
          session,
          challengeParameters: { USER_ID_FOR_SRP: username },
        };
      }
      return { tokens: makeTokens(poolId, username, user.attributes) };
    }
    if (authFlow === "REFRESH_TOKEN_AUTH" || authFlow === "REFRESH_TOKEN") {
      // Accept any refresh token and return new tokens
      const username = authParameters["USERNAME"] ?? "unknown";
      const users = this.poolUsers(poolId);
      const user = users.get(username);
      if (!user) throw new Error(`NotAuthorizedException: Invalid refresh token`);
      return { tokens: makeTokens(poolId, username, user.attributes) };
    }
    throw new Error(`NotAuthorizedException: Auth flow ${authFlow} not supported`);
  }

  initiateAuth(
    clientId: string,
    authFlow: string,
    authParameters: Record<string, string>
  ): { tokens?: ReturnType<typeof makeTokens>; challengeName?: string; session?: string; challengeParameters?: Record<string, string> } {
    const client = this.clients.get(clientId);
    if (!client) throw new Error(`ResourceNotFoundException: Client ${clientId} not found`);
    return this.adminInitiateAuth(client.poolId, authFlow, authParameters);
  }

  respondToAuthChallenge(
    clientId: string,
    challengeName: string,
    session: string,
    challengeResponses: Record<string, string>
  ): { tokens?: ReturnType<typeof makeTokens> } {
    const authSession = this.authSessions.get(session);
    if (!authSession) throw new Error(`NotAuthorizedException: Invalid session`);
    this.authSessions.delete(session);

    if (challengeName === "NEW_PASSWORD_REQUIRED") {
      const newPassword = challengeResponses["NEW_PASSWORD"];
      if (!newPassword) throw new Error(`InvalidParameterException: NEW_PASSWORD required`);
      const user = this.adminGetUser(authSession.poolId, authSession.username);
      user.password = newPassword;
      user.status = "CONFIRMED";
      user.temporaryPassword = undefined;
      user.lastModifiedDate = Date.now() / 1000;
      return { tokens: makeTokens(authSession.poolId, authSession.username, user.attributes) };
    }
    throw new Error(`NotAuthorizedException: Challenge ${challengeName} not supported`);
  }
}
