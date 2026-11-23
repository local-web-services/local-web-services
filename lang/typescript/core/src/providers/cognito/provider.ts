import { randomUUID } from "crypto";
import type { IProvider } from "../../interfaces/provider.js";
import { generatePoolKeys, signAccessToken, signIdToken } from "./auth.js";
import type { KeyLike } from "./auth.js";
import { decodeJwt } from "jose";

export interface UserPoolConfig {
  poolName: string;
  autoConfirmUsers?: boolean;
}

interface StoredClient {
  clientId: string;
  clientName: string;
  poolId: string;
}

interface StoredUser {
  username: string;
  sub: string;
  email: string | undefined;
  password: string;
  status: "CONFIRMED" | "UNCONFIRMED" | "FORCE_CHANGE_PASSWORD";
  enabled: boolean;
  attributes: { Name: string; Value: string }[];
  createdAt: number;
}

interface StoredPool {
  id: string;
  name: string;
  arn: string;
  privateKey: KeyLike;
  publicKey: KeyLike;
  clients: Map<string, StoredClient>;
  users: Map<string, StoredUser>;
  createdAt: number;
}

const REGION = "us-east-1";
const ACCOUNT = "123456789012";

function randomAlphanumeric(len: number): string {
  const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  let result = "";
  for (let i = 0; i < len; i++) {
    result += chars[Math.floor(Math.random() * chars.length)];
  }
  return result;
}

function poolId(): string {
  return `${REGION}_${randomAlphanumeric(9)}`;
}

function clientId(): string {
  return randomAlphanumeric(26);
}

export class CognitoProvider implements IProvider {
  readonly name = "cognito-idp";

  private _pools = new Map<string, StoredPool>();
  private _poolsByName = new Map<string, string>();
  private _clientToPool = new Map<string, string>();
  private _preconfiguredNames: ReadonlySet<string>;
  private _configs: UserPoolConfig[];

  constructor(configs: UserPoolConfig[] = []) {
    this._configs = configs;
    this._preconfiguredNames = new Set(configs.map((c) => c.poolName));
  }

  async start(): Promise<void> {
    for (const config of this._configs) {
      await this._seedPool(config.poolName);
    }
  }

  async stop(): Promise<void> {
    this._pools.clear();
    this._poolsByName.clear();
    this._clientToPool.clear();
  }

  async reset(): Promise<void> {
    for (const [id, pool] of [...this._pools.entries()]) {
      if (!this._preconfiguredNames.has(pool.name)) {
        this._poolsByName.delete(pool.name);
        this._pools.delete(id);
      } else {
        pool.users.clear();
        pool.clients.clear();
      }
    }
    this._clientToPool.clear();
  }

  async healthCheck(): Promise<boolean> {
    return true;
  }

  private async _seedPool(name: string): Promise<StoredPool> {
    const id = poolId();
    const arn = `arn:aws:cognito-idp:${REGION}:${ACCOUNT}:userpool/${id}`;
    const { privateKey, publicKey } = await generatePoolKeys();
    const pool: StoredPool = {
      id,
      name,
      arn,
      privateKey,
      publicKey,
      clients: new Map(),
      users: new Map(),
      createdAt: Math.floor(Date.now() / 1000),
    };
    this._pools.set(id, pool);
    this._poolsByName.set(name, id);
    return pool;
  }

  private _getPool(poolId: string): StoredPool {
    const pool = this._pools.get(poolId);
    if (!pool) throw new Error("ResourceNotFoundException: User pool not found.");
    return pool;
  }

  private _resolvePoolId(idOrArn: string): string {
    if (idOrArn.includes("userpool/")) {
      const parts = idOrArn.split("userpool/");
      return parts[1] ?? idOrArn;
    }
    return idOrArn;
  }

  async createUserPool(name: string): Promise<{ UserPool: Record<string, unknown> }> {
    const pool = await this._seedPool(name);
    return { UserPool: this._poolDesc(pool) };
  }

  deleteUserPool(poolId: string): void {
    const id = this._resolvePoolId(poolId);
    const pool = this._getPool(id);
    this._poolsByName.delete(pool.name);
    this._pools.delete(id);
  }

  listUserPools(): { UserPools: Record<string, unknown>[] } {
    const list = [...this._pools.values()].map((p) => ({
      Id: p.id,
      Name: p.name,
      Arn: p.arn,
      CreationDate: p.createdAt,
      LastModifiedDate: p.createdAt,
      Status: "Active",
    }));
    return { UserPools: list };
  }

  describeUserPool(poolId: string): { UserPool: Record<string, unknown> } {
    const id = this._resolvePoolId(poolId);
    const pool = this._getPool(id);
    return { UserPool: this._poolDesc(pool) };
  }

  createUserPoolClient(poolId: string, clientName: string): { UserPoolClient: Record<string, unknown> } {
    const id = this._resolvePoolId(poolId);
    const pool = this._getPool(id);
    const cid = clientId();
    const client: StoredClient = { clientId: cid, clientName, poolId: id };
    pool.clients.set(cid, client);
    this._clientToPool.set(cid, id);
    return { UserPoolClient: { ClientId: cid, ClientName: clientName, UserPoolId: id } };
  }

  deleteUserPoolClient(poolId: string, cid: string): void {
    const id = this._resolvePoolId(poolId);
    const pool = this._getPool(id);
    pool.clients.delete(cid);
    this._clientToPool.delete(cid);
  }

  listUserPoolClients(poolId: string): { UserPoolClients: Record<string, unknown>[] } {
    const id = this._resolvePoolId(poolId);
    const pool = this._getPool(id);
    const list = [...pool.clients.values()].map((c) => ({
      ClientId: c.clientId,
      ClientName: c.clientName,
      UserPoolId: c.poolId,
    }));
    return { UserPoolClients: list };
  }

  adminCreateUser(
    poolId: string,
    username: string,
    tempPassword?: string,
    userAttributes?: { Name: string; Value: string }[],
  ): { User: Record<string, unknown> } {
    const id = this._resolvePoolId(poolId);
    const pool = this._getPool(id);
    if (pool.users.has(username)) {
      throw new Error("UsernameExistsException: User already exists.");
    }
    const attrs = userAttributes ?? [];
    const emailAttr = attrs.find((a) => a.Name === "email");
    const adminEmail: string | undefined = emailAttr?.Value;
    const user: StoredUser = {
      username,
      sub: randomUUID(),
      email: adminEmail,
      password: tempPassword ?? "TempPass123!",
      status: "CONFIRMED",
      enabled: true,
      attributes: attrs,
      createdAt: Math.floor(Date.now() / 1000),
    };
    pool.users.set(username, user);
    return { User: this._userDesc(user) };
  }

  adminDeleteUser(poolId: string, username: string): void {
    const id = this._resolvePoolId(poolId);
    const pool = this._getPool(id);
    if (!pool.users.has(username)) {
      throw new Error("UserNotFoundException: User does not exist.");
    }
    pool.users.delete(username);
  }

  adminGetUser(poolId: string, username: string): Record<string, unknown> {
    const id = this._resolvePoolId(poolId);
    const pool = this._getPool(id);
    const user = pool.users.get(username);
    if (!user) throw new Error("UserNotFoundException: User does not exist.");
    return this._userDesc(user);
  }

  adminSetUserPassword(poolId: string, username: string, password: string): void {
    const id = this._resolvePoolId(poolId);
    const pool = this._getPool(id);
    const user = pool.users.get(username);
    if (!user) throw new Error("UserNotFoundException: User does not exist.");
    user.password = password;
    user.status = "CONFIRMED";
  }

  listUsers(poolId: string): { Users: Record<string, unknown>[] } {
    const id = this._resolvePoolId(poolId);
    const pool = this._getPool(id);
    return { Users: [...pool.users.values()].map((u) => this._userDesc(u)) };
  }

  async initiateAuth(
    cid: string,
    _authFlow: string,
    authParams: Record<string, string>,
    poolIdHint?: string,
  ): Promise<{ AuthenticationResult: Record<string, unknown> }> {
    const username = authParams["USERNAME"] ?? "";
    const password = authParams["PASSWORD"] ?? "";
    const resolvedPid = poolIdHint ? this._resolvePoolId(poolIdHint) : this._clientToPool.get(cid);
    if (!resolvedPid) throw new Error("ResourceNotFoundException: User pool client not found.");
    const pool = this._getPool(resolvedPid);
    const pid = resolvedPid;
    const user = pool.users.get(username);
    if (!user) throw new Error("UserNotFoundException: User does not exist.");
    if (user.password !== password) throw new Error("NotAuthorizedException: Incorrect username or password.");
    const issuer = `https://cognito-idp.${REGION}.amazonaws.com/${pid}`;
    const idTokenOpts = user.email !== undefined
      ? { sub: user.sub, username, email: user.email, poolId: pid, clientId: cid, issuer }
      : { sub: user.sub, username, poolId: pid, clientId: cid, issuer };
    const accessToken = await signAccessToken(pool.privateKey, { sub: user.sub, username, poolId: pid, clientId: cid, issuer });
    const idToken = await signIdToken(pool.privateKey, idTokenOpts);
    return {
      AuthenticationResult: {
        AccessToken: accessToken,
        IdToken: idToken,
        RefreshToken: `refresh-${randomUUID()}`,
        ExpiresIn: 3600,
        TokenType: "Bearer",
      },
    };
  }

  getUser(accessToken: string): Record<string, unknown> {
    const payload = decodeJwt(accessToken);
    const sub = payload["sub"] as string;
    const username = (payload["username"] as string | undefined) ?? sub;
    for (const pool of this._pools.values()) {
      const user = pool.users.get(username);
      if (user && user.sub === sub) {
        return { Username: user.username, UserAttributes: user.attributes, UserPoolId: pool.id };
      }
    }
    throw new Error("NotAuthorizedException: Access token is invalid.");
  }

  signUp(
    cid: string,
    username: string,
    password: string,
    userAttributes?: { Name: string; Value: string }[],
  ): { UserSub: string; UserConfirmed: boolean } {
    const pid = this._clientToPool.get(cid);
    if (!pid) throw new Error("ResourceNotFoundException: User pool client not found.");
    const pool = this._getPool(pid);
    if (pool.users.has(username)) {
      throw new Error("UsernameExistsException: An account with the given email already exists.");
    }
    const attrs = userAttributes ?? [];
    const emailAttr = attrs.find((a) => a.Name === "email");
    const sub = randomUUID();
    const signupEmail: string | undefined = emailAttr?.Value;
    const user: StoredUser = {
      username,
      sub,
      email: signupEmail,
      password,
      status: "CONFIRMED",
      enabled: true,
      attributes: attrs,
      createdAt: Math.floor(Date.now() / 1000),
    };
    pool.users.set(username, user);
    return { UserSub: sub, UserConfirmed: true };
  }

  confirmSignUp(_cid: string, _username: string, _code: string): void {
    // local: auto-confirm, any code works
  }

  private _poolDesc(pool: StoredPool): Record<string, unknown> {
    return {
      Id: pool.id,
      Name: pool.name,
      Arn: pool.arn,
      CreationDate: pool.createdAt,
      LastModifiedDate: pool.createdAt,
      Status: "Active",
    };
  }

  private _userDesc(user: StoredUser): Record<string, unknown> {
    return {
      Username: user.username,
      Attributes: user.attributes,
      UserCreateDate: user.createdAt,
      UserLastModifiedDate: user.createdAt,
      Enabled: user.enabled,
      UserStatus: user.status,
      sub: user.sub,
    };
  }
}
