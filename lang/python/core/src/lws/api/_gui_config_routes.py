"""CSS styles and HTML structure constants for the LDK dashboard.

Exports string constants used by ``gui.py`` to assemble the full dashboard HTML.
"""

from __future__ import annotations

_DASHBOARD_CSS = """\
<style>
:root {
  --bg: #0f1117; --bg2: #1a1b26; --bg3: #24253a; --bg4: #2a2b3d;
  --fg: #c0caf5; --fg2: #565f89; --fg3: #414868;
  --accent: #7aa2f7; --green: #9ece6a; --yellow: #e0af68;
  --red: #f7768e; --cyan: #7dcfff; --magenta: #bb9af7; --orange: #ff9e64;
  --border: #292e42; --radius: 5px;
}
* { margin:0; padding:0; box-sizing:border-box; }
body { font-family:'SF Mono',Menlo,Consolas,monospace; background:var(--bg);
  color:var(--fg); font-size:13px; height:100vh; display:flex; flex-direction:column;
  overflow:hidden; }
header { background:var(--bg2); border-bottom:1px solid var(--border);
  padding:8px 16px; display:flex; align-items:center; gap:16px; flex-shrink:0; }
header h1 { font-size:15px; color:var(--accent); font-weight:700; letter-spacing:1px; }
nav { display:flex; gap:4px; }
nav button { background:none; border:1px solid transparent; color:var(--fg2);
  padding:5px 13px; border-radius:var(--radius); cursor:pointer; font:inherit; font-size:12px; }
nav button:hover { color:var(--fg); background:var(--bg3); }
nav button.active { color:var(--accent); border-color:var(--accent); background:var(--bg3); }
.ws-dot { width:7px; height:7px; border-radius:50%; display:inline-block; margin-left:auto; }
.ws-dot.on { background:var(--green); box-shadow:0 0 4px var(--green); }
.ws-dot.off { background:var(--red); }
main { flex:1; overflow:hidden; position:relative; display:flex; flex-direction:column; }
.panel { display:none; flex:1; flex-direction:column; overflow:hidden; }
.panel.active { display:flex; }

/* ── Toolbar ── */
.toolbar { display:flex; gap:6px; align-items:center; padding:8px 16px;
  border-bottom:1px solid var(--border); flex-shrink:0; background:var(--bg); }
.toolbar button, .toolbar select, .toolbar input {
  background:var(--bg3); border:1px solid var(--border); color:var(--fg);
  padding:4px 10px; border-radius:var(--radius); cursor:pointer; font:inherit; font-size:12px; }
.toolbar button:hover { border-color:var(--accent); }
.toolbar input { padding:4px 8px; min-width:140px; }
.toolbar input::placeholder { color:var(--fg3); }
.tb-count { color:var(--fg2); font-size:11px; margin-left:auto; white-space:nowrap; }
.tb-sep { width:1px; height:18px; background:var(--border); }

/* ── Badges ── */
.badge { display:inline-flex; align-items:center; padding:1px 5px;
  border-radius:3px; font-size:10px; font-weight:700; letter-spacing:0.3px;
  white-space:nowrap; line-height:1.6; }
.m-get    { background:rgba(125,207,255,.12); color:var(--cyan);    border:1px solid rgba(125,207,255,.3); }
.m-post   { background:rgba(122,162,247,.12); color:var(--accent);  border:1px solid rgba(122,162,247,.3); }
.m-put    { background:rgba(255,158,100,.12); color:var(--orange);  border:1px solid rgba(255,158,100,.3); }
.m-delete { background:rgba(247,118,142,.12); color:var(--red);     border:1px solid rgba(247,118,142,.3); }
.m-head   { background:rgba(86,95,137,.15);   color:var(--fg2);     border:1px solid var(--border); }
.m-patch  { background:rgba(187,154,247,.12); color:var(--magenta); border:1px solid rgba(187,154,247,.3); }
.s-2xx { background:rgba(158,206,106,.13); color:var(--green);   border:1px solid rgba(158,206,106,.3); }
.s-4xx { background:rgba(224,175,104,.13); color:var(--yellow);  border:1px solid rgba(224,175,104,.3); }
.s-5xx { background:rgba(247,118,142,.13); color:var(--red);     border:1px solid rgba(247,118,142,.3); }
.svc-badge { min-width:72px; text-align:center; font-size:10px; }
.svc-dynamodb    { background:rgba(122,162,247,.1); color:var(--accent);  border:1px solid rgba(122,162,247,.25); }
.svc-sqs         { background:rgba(255,158,100,.1); color:var(--orange);  border:1px solid rgba(255,158,100,.25); }
.svc-s3          { background:rgba(158,206,106,.1); color:var(--green);   border:1px solid rgba(158,206,106,.25); }
.svc-sns         { background:rgba(187,154,247,.1); color:var(--magenta); border:1px solid rgba(187,154,247,.25); }
.svc-events      { background:rgba(125,207,255,.1); color:var(--cyan);    border:1px solid rgba(125,207,255,.25); }
.svc-stepfunctions { background:rgba(187,154,247,.1); color:var(--magenta); border:1px solid rgba(187,154,247,.25); }
.svc-cognitoidp  { background:rgba(224,175,104,.1); color:var(--yellow);  border:1px solid rgba(224,175,104,.25); }
.svc-ssm         { background:rgba(125,207,255,.1); color:var(--cyan);    border:1px solid rgba(125,207,255,.25); }
.svc-secretsmanager { background:rgba(158,206,106,.1); color:var(--green); border:1px solid rgba(158,206,106,.25); }
.svc-lambda      { background:rgba(158,206,106,.1); color:var(--green);   border:1px solid rgba(158,206,106,.25); }
.svc-apigateway  { background:rgba(122,162,247,.1); color:var(--accent);  border:1px solid rgba(122,162,247,.25); }
.svc-other       { background:rgba(86,95,137,.15);  color:var(--fg2);     border:1px solid var(--border); }
.iam-allow { background:rgba(158,206,106,.15); color:var(--green);  border:1px solid rgba(158,206,106,.3); }
.iam-deny  { background:rgba(247,118,142,.15); color:var(--red);    border:1px solid rgba(247,118,142,.3); }
.iam-audit { background:rgba(224,175,104,.15); color:var(--yellow); border:1px solid rgba(224,175,104,.3); }

/* ── Event list ── */
#event-list { flex:1; overflow-y:auto; min-height:0; }
.ev-row { display:flex; align-items:center; gap:6px; padding:5px 16px;
  border-bottom:1px solid rgba(41,46,66,.6); cursor:pointer; transition:background .08s; }
.ev-row:hover { background:var(--bg2); }
.ev-row.sel { background:var(--bg3); border-left:2px solid var(--accent); padding-left:14px; }
.ev-ts { color:var(--fg2); font-size:11px; min-width:62px; }
.ev-op { flex:1; color:var(--fg); overflow:hidden; text-overflow:ellipsis; white-space:nowrap;
  font-size:12px; }
.ev-dur { color:var(--fg2); font-size:11px; min-width:42px; text-align:right; }

/* text log rows (non-request) */
.log-row { padding:4px 16px; border-bottom:1px solid rgba(41,46,66,.4); font-size:12px;
  line-height:1.5; white-space:pre-wrap; word-break:break-all; }
.log-row .ts  { color:var(--fg2); }
.log-row .lvl-DEBUG    { color:var(--fg2); }
.log-row .lvl-INFO     { color:var(--cyan); }
.log-row .lvl-WARNING  { color:var(--yellow); }
.log-row .lvl-ERROR    { color:var(--red); font-weight:600; }
.log-row .lvl-CRITICAL { color:var(--red); font-weight:700;
  background:rgba(247,118,142,.15); padding:0 3px; border-radius:2px; }

/* ── Detail panel ── */
#detail-panel { flex-shrink:0; height:480px; border-top:2px solid var(--border);
  overflow-y:auto; display:none; flex-direction:column; background:var(--bg); }
#detail-panel.open { display:flex; }
.detail-resize { height:5px; cursor:ns-resize; background:transparent; flex-shrink:0;
  position:relative; z-index:10; }
.detail-resize:hover, .detail-resize.dragging { background:var(--accent); opacity:.5; }
.detail-hdr { display:flex; align-items:center; gap:8px; padding:8px 16px;
  background:var(--bg2); border-bottom:1px solid var(--border);
  position:sticky; top:0; z-index:2; flex-shrink:0; }
.detail-hdr-title { flex:1; display:flex; align-items:center; gap:6px; flex-wrap:wrap; }
.detail-close { background:none; border:none; color:var(--fg2); cursor:pointer;
  font-size:14px; padding:2px 6px; border-radius:3px; }
.detail-close:hover { color:var(--fg); background:var(--bg3); }
.detail-body { flex:1; overflow-y:auto; }
.det-section { padding:10px 16px; border-bottom:1px solid var(--border); }
.det-section-title { color:var(--fg2); font-size:10px; letter-spacing:1.2px;
  text-transform:uppercase; margin-bottom:8px; font-weight:600; }
.det-kv { display:flex; flex-wrap:wrap; gap:16px; }
.det-kv-item { display:flex; flex-direction:column; gap:2px; }
.det-kv-key { color:var(--fg2); font-size:10px; }
.det-kv-val { color:var(--fg); font-size:12px; }
.det-pre { margin:0; padding:8px 10px; background:var(--bg3); border-radius:4px;
  font-size:11px; overflow-x:auto; white-space:pre-wrap; word-break:break-all;
  color:var(--fg); line-height:1.5; max-height:180px; overflow-y:auto; }

/* ── Resources panel ── */
#resources-panel { overflow-y:auto; }
.svc-group { background:var(--bg2); border:1px solid var(--border);
  border-radius:var(--radius); margin:12px 16px 0; overflow:hidden; }
.svc-head { padding:10px 14px; display:flex; align-items:center; gap:10px;
  cursor:pointer; user-select:none; }
.svc-head:hover { background:var(--bg3); }
.svc-head .svc-name { font-weight:600; color:var(--accent); text-transform:uppercase;
  font-size:12px; }
.svc-head .svc-port { color:var(--fg2); font-size:11px; }
.svc-head .svc-health { margin-left:auto; font-size:11px; }
.svc-head .svc-health.healthy { color:var(--green); }
.svc-head .svc-health.unhealthy { color:var(--red); }
.svc-head .arrow { color:var(--fg2); transition:transform .15s; font-size:10px; }
.svc-head .arrow.open { transform:rotate(90deg); }
.svc-body { border-top:1px solid var(--border); }
.res-row { padding:8px 14px; display:flex; align-items:center; gap:8px;
  border-bottom:1px solid var(--border); }
.res-row:last-child { border-bottom:none; }
.res-row .rn { flex:1; font-size:12px; }
.res-row button { background:var(--bg3); border:1px solid var(--border);
  color:var(--fg); padding:3px 8px; border-radius:var(--radius);
  cursor:pointer; font:inherit; font-size:11px; }
.res-row button:hover { border-color:var(--accent); color:var(--accent); }
.res-tb { display:flex; gap:8px; padding:12px 16px;
  border-bottom:1px solid var(--border); }
.res-tb button { background:var(--bg3); border:1px solid var(--border); color:var(--fg);
  padding:4px 10px; border-radius:var(--radius); cursor:pointer; font:inherit; font-size:12px; }
.res-tb button:hover { border-color:var(--accent); }

/* ── Invoke panel ── */
#invoke-panel { overflow-y:auto; padding:12px 16px; }
.inv-hdr { margin-bottom:12px; display:flex; align-items:center; gap:8px; }
.inv-hdr button { background:var(--bg3); border:1px solid var(--border); color:var(--fg);
  padding:4px 10px; border-radius:var(--radius); cursor:pointer; font:inherit; font-size:12px; }
.inv-form { background:var(--bg2); border:1px solid var(--border);
  border-radius:var(--radius); padding:14px; margin-bottom:12px; }
.inv-form label { display:block; color:var(--fg2); font-size:11px;
  margin-bottom:4px; margin-top:10px; }
.inv-form label:first-child { margin-top:0; }
.inv-form input, .inv-form textarea, .inv-form select {
  width:100%; background:var(--bg); border:1px solid var(--border);
  color:var(--fg); padding:6px 8px; border-radius:var(--radius); font:inherit; font-size:12px; }
.inv-form textarea { min-height:80px; resize:vertical; }
.inv-form .btn-row { margin-top:12px; display:flex; gap:8px; }
.inv-form button { padding:5px 14px; border-radius:var(--radius);
  cursor:pointer; font:inherit; font-size:12px; border:1px solid var(--border); }
.inv-exec { background:var(--accent); color:var(--bg); border-color:var(--accent); font-weight:600; }
.inv-exec:hover { opacity:.9; }
#inv-result { background:var(--bg2); border:1px solid var(--border);
  border-radius:var(--radius); padding:12px; white-space:pre-wrap;
  word-break:break-all; max-height:50vh; overflow-y:auto; font-size:12px; }
#inv-result.err { border-color:var(--red); color:var(--red); }
.empty { color:var(--fg2); text-align:center; padding:48px 16px; font-size:12px; }
</style>
"""

_DASHBOARD_HTML_STRUCTURE = """\
</head>
<body>

<header>
  <h1>LDK</h1>
  <nav>
    <button class="tab active" data-tab="logs">Logs</button>
    <button class="tab" data-tab="resources">Resources</button>
    <button class="tab" data-tab="invoke">Invoke</button>
  </nav>
  <span id="ws-dot" class="ws-dot off" title="WebSocket disconnected"></span>
</header>

<main>
  <!-- Logs panel -->
  <div id="logs" class="panel active">
    <div class="toolbar">
      <button id="btn-pause">Pause</button>
      <button id="btn-clear">Clear</button>
      <div class="tb-sep"></div>
      <select id="lv-filter">
        <option value="DEBUG">All levels</option>
        <option value="INFO" selected>INFO+</option>
        <option value="WARNING">WARN+</option>
        <option value="ERROR">ERROR+</option>
      </select>
      <select id="iam-filter">
        <option value="all">All requests</option>
        <option value="iam">IAM events only</option>
        <option value="deny">IAM DENY only</option>
      </select>
      <input id="svc-filter" placeholder="Filter service/op…" autocomplete="off">
      <span class="tb-count" id="ev-count">0 entries</span>
    </div>
    <div id="event-list"></div>
    <div id="detail-panel">
      <div class="detail-resize" id="detail-resize" title="Drag to resize"></div>
      <div class="detail-hdr">
        <div class="detail-hdr-title" id="detail-title"></div>
        <button class="detail-close" id="btn-detail-close" title="Close">✕</button>
      </div>
      <div class="detail-body" id="detail-body"></div>
    </div>
  </div>

  <!-- Resources panel -->
  <div id="resources" class="panel">
    <div class="res-tb">
      <button id="btn-refresh">Refresh</button>
    </div>
    <div id="resources-panel" class="panel active" style="overflow-y:auto;padding-bottom:16px;">
      <div class="empty">Loading resources…</div>
    </div>
  </div>

  <!-- Invoke panel -->
  <div id="invoke" class="panel">
    <div id="invoke-panel">
      <div class="empty">Select an action from the Resources tab.</div>
    </div>
  </div>
</main>

"""
