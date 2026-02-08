"""Self-contained HTML dashboard for LDK.

Returns an ``HTMLResponse`` with inline CSS and JavaScript — no external
dependencies, no build step, works offline.
"""

from __future__ import annotations

from fastapi.responses import HTMLResponse

_DASHBOARD_HTML = """\
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>LDK Dashboard</title>
<style>
:root {
  --bg: #0f1117; --bg2: #1a1b26; --bg3: #24253a;
  --fg: #c0caf5; --fg2: #565f89; --accent: #7aa2f7;
  --green: #9ece6a; --yellow: #e0af68; --red: #f7768e;
  --cyan: #7dcfff; --magenta: #bb9af7; --orange: #ff9e64;
  --border: #292e42; --radius: 6px;
}
* { margin:0; padding:0; box-sizing:border-box; }
body { font-family: 'SF Mono',Menlo,Consolas,monospace; background:var(--bg);
  color:var(--fg); font-size:13px; height:100vh; display:flex; flex-direction:column; }
header { background:var(--bg2); border-bottom:1px solid var(--border);
  padding:8px 16px; display:flex; align-items:center; gap:16px; }
header h1 { font-size:16px; color:var(--accent); font-weight:600; }
nav { display:flex; gap:4px; }
nav button { background:none; border:1px solid transparent; color:var(--fg2);
  padding:6px 14px; border-radius:var(--radius); cursor:pointer; font:inherit; }
nav button:hover { color:var(--fg); background:var(--bg3); }
nav button.active { color:var(--accent); border-color:var(--accent);
  background:var(--bg3); }
.status-dot { width:8px; height:8px; border-radius:50%; display:inline-block;
  margin-left:auto; }
.status-dot.connected { background:var(--green); }
.status-dot.disconnected { background:var(--red); }
main { flex:1; overflow:hidden; position:relative; }
.panel { position:absolute; inset:0; overflow-y:auto; padding:12px 16px;
  display:none; }
.panel.active { display:block; }

/* Logs */
#logs-toolbar { display:flex; gap:8px; align-items:center; margin-bottom:8px;
  position:sticky; top:0; background:var(--bg); z-index:1; padding:4px 0; }
#logs-toolbar button, #logs-toolbar select { background:var(--bg3);
  border:1px solid var(--border); color:var(--fg); padding:4px 10px;
  border-radius:var(--radius); cursor:pointer; font:inherit; }
#logs-toolbar button:hover { border-color:var(--accent); }
#log-count { color:var(--fg2); margin-left:auto; font-size:12px; }
#log-container { padding-bottom:8px; }
.log-entry { padding:2px 0; white-space:pre-wrap; word-break:break-all;
  line-height:1.5; }
.log-entry .ts { color:var(--fg2); }
.log-entry .lvl-DEBUG { color:var(--fg2); }
.log-entry .lvl-INFO { color:var(--cyan); }
.log-entry .lvl-WARNING { color:var(--yellow); }
.log-entry .lvl-ERROR { color:var(--red); font-weight:600; }
.log-entry .lvl-CRITICAL { color:var(--red); font-weight:700;
  background:rgba(247,118,142,0.15); padding:0 4px; border-radius:2px; }
.log-entry .status-2xx { color:var(--green); }
.log-entry .status-4xx { color:var(--yellow); }
.log-entry .status-5xx { color:var(--red); }

/* Resources */
.svc-group { background:var(--bg2); border:1px solid var(--border);
  border-radius:var(--radius); margin-bottom:12px; overflow:hidden; }
.svc-header { padding:10px 14px; display:flex; align-items:center; gap:10px;
  cursor:pointer; user-select:none; }
.svc-header:hover { background:var(--bg3); }
.svc-header .svc-name { font-weight:600; color:var(--accent); text-transform:uppercase; }
.svc-header .svc-port { color:var(--fg2); font-size:12px; }
.svc-header .svc-health { margin-left:auto; font-size:12px; }
.svc-header .svc-health.healthy { color:var(--green); }
.svc-header .svc-health.unhealthy { color:var(--red); }
.svc-header .arrow { color:var(--fg2); transition:transform .15s; }
.svc-header .arrow.open { transform:rotate(90deg); }
.svc-body { border-top:1px solid var(--border); }
.resource-row { padding:8px 14px; display:flex; align-items:center;
  gap:8px; border-bottom:1px solid var(--border); }
.resource-row:last-child { border-bottom:none; }
.resource-row .res-name { flex:1; }
.resource-row button { background:var(--bg3); border:1px solid var(--border);
  color:var(--fg); padding:3px 8px; border-radius:var(--radius);
  cursor:pointer; font:inherit; font-size:12px; }
.resource-row button:hover { border-color:var(--accent); color:var(--accent); }
#resources-toolbar { display:flex; gap:8px; margin-bottom:12px;
  position:sticky; top:0; background:var(--bg); z-index:1; padding:4px 0; }
#resources-toolbar button { background:var(--bg3); border:1px solid var(--border);
  color:var(--fg); padding:4px 10px; border-radius:var(--radius);
  cursor:pointer; font:inherit; }
#resources-toolbar button:hover { border-color:var(--accent); }

/* Invoke */
#invoke-panel .invoke-header { margin-bottom:12px; display:flex;
  align-items:center; gap:8px; }
#invoke-panel .invoke-header button { background:var(--bg3);
  border:1px solid var(--border); color:var(--fg); padding:4px 10px;
  border-radius:var(--radius); cursor:pointer; font:inherit; }
.invoke-form { background:var(--bg2); border:1px solid var(--border);
  border-radius:var(--radius); padding:14px; margin-bottom:12px; }
.invoke-form label { display:block; color:var(--fg2); font-size:12px;
  margin-bottom:4px; margin-top:10px; }
.invoke-form label:first-child { margin-top:0; }
.invoke-form input, .invoke-form textarea, .invoke-form select {
  width:100%; background:var(--bg); border:1px solid var(--border);
  color:var(--fg); padding:6px 8px; border-radius:var(--radius);
  font:inherit; }
.invoke-form textarea { min-height:80px; resize:vertical; }
.invoke-form .btn-row { margin-top:12px; display:flex; gap:8px; }
.invoke-form button { padding:6px 16px; border-radius:var(--radius);
  cursor:pointer; font:inherit; border:1px solid var(--border); }
.invoke-form .btn-exec { background:var(--accent); color:var(--bg);
  border-color:var(--accent); font-weight:600; }
.invoke-form .btn-exec:hover { opacity:0.9; }
#invoke-result { background:var(--bg2); border:1px solid var(--border);
  border-radius:var(--radius); padding:14px; white-space:pre-wrap;
  word-break:break-all; max-height:50vh; overflow-y:auto; }
#invoke-result.error { border-color:var(--red); color:var(--red); }
.empty-state { color:var(--fg2); text-align:center; padding:48px 16px; }
</style>
</head>
<body>

<header>
  <h1>LDK</h1>
  <nav>
    <button class="tab active" data-tab="logs">Logs</button>
    <button class="tab" data-tab="resources">Resources</button>
    <button class="tab" data-tab="invoke">Invoke</button>
  </nav>
  <span id="ws-status" class="status-dot disconnected" title="WebSocket disconnected"></span>
</header>

<main>
  <!-- Logs Panel -->
  <div id="logs" class="panel active">
    <div id="logs-toolbar">
      <button id="btn-pause">Pause</button>
      <button id="btn-clear">Clear</button>
      <select id="log-level-filter">
        <option value="DEBUG">All levels</option>
        <option value="INFO" selected>INFO+</option>
        <option value="WARNING">WARN+</option>
        <option value="ERROR">ERROR+</option>
      </select>
      <span id="log-count">0 entries</span>
    </div>
    <div id="log-container"></div>
  </div>

  <!-- Resources Panel -->
  <div id="resources" class="panel">
    <div id="resources-toolbar">
      <button id="btn-refresh">Refresh</button>
    </div>
    <div id="resources-container">
      <div class="empty-state">Loading resources...</div>
    </div>
  </div>

  <!-- Invoke Panel -->
  <div id="invoke" class="panel">
    <div id="invoke-content">
      <div class="empty-state">Select an action from the Resources tab to invoke an operation.</div>
    </div>
  </div>
</main>

<script>
(function() {
  "use strict";

  // --- State ---
  let ws = null;
  let paused = false;
  let logEntries = [];
  let resourceData = null;
  let statusData = null;
  const LEVEL_ORDER = {DEBUG:0, INFO:1, WARNING:2, ERROR:3, CRITICAL:4};
  const BASE = window.location.origin;

  // --- Tabs ---
  document.querySelectorAll('.tab').forEach(btn => {
    btn.addEventListener('click', () => {
      document.querySelectorAll('.tab').forEach(b => b.classList.remove('active'));
      document.querySelectorAll('.panel').forEach(p => p.classList.remove('active'));
      btn.classList.add('active');
      document.getElementById(btn.dataset.tab).classList.add('active');
      if (btn.dataset.tab === 'resources') loadResources();
    });
  });

  // --- Logs ---
  const logContainer = document.getElementById('log-container');
  const logCount = document.getElementById('log-count');
  const levelFilter = document.getElementById('log-level-filter');
  const wsStatus = document.getElementById('ws-status');

  function connectWs() {
    const proto = location.protocol === 'https:' ? 'wss:' : 'ws:';
    ws = new WebSocket(proto + '//' + location.host + '/_ldk/ws/logs');
    ws.onopen = () => {
      wsStatus.className = 'status-dot connected';
      wsStatus.title = 'WebSocket connected';
    };
    ws.onclose = () => {
      wsStatus.className = 'status-dot disconnected';
      wsStatus.title = 'WebSocket disconnected';
      setTimeout(connectWs, 2000);
    };
    ws.onerror = () => { ws.close(); };
    ws.onmessage = (e) => {
      try {
        const entry = JSON.parse(e.data);
        logEntries.push(entry);
        if (logEntries.length > 2000) logEntries = logEntries.slice(-1500);
        appendLogEntry(entry);
      } catch(_) {}
    };
  }

  function appendLogEntry(entry) {
    const minLevel = LEVEL_ORDER[levelFilter.value] || 0;
    const entryLevel = LEVEL_ORDER[entry.level] || 0;
    if (entryLevel < minLevel) return;

    const div = document.createElement('div');
    div.className = 'log-entry';
    const ts = '<span class="ts">[' + esc(entry.timestamp || '') + ']</span> ';
    const lvl = '<span class="lvl-' + esc(entry.level || 'INFO') + '">' +
                esc(entry.level || 'INFO') + '</span> ';
    let msg = esc(entry.message || '');
    if (entry.status_code) {
      const sc = String(entry.status_code);
      const cls = sc.startsWith('2') ? 'status-2xx' : sc.startsWith('4') ? 'status-4xx' : 'status-5xx';
      msg = msg.replace(sc, '<span class="' + cls + '">' + sc + '</span>');
    }
    div.innerHTML = ts + lvl + msg;
    div.dataset.level = entry.level || 'INFO';
    logContainer.appendChild(div);
    updateLogCount();
    if (!paused) logContainer.scrollIntoView({block:'end'});
  }

  function updateLogCount() {
    const visible = logContainer.children.length;
    logCount.textContent = visible + ' entr' + (visible === 1 ? 'y' : 'ies');
  }

  function refilterLogs() {
    logContainer.innerHTML = '';
    logEntries.forEach(e => appendLogEntry(e));
  }

  levelFilter.addEventListener('change', refilterLogs);

  document.getElementById('btn-pause').addEventListener('click', function() {
    paused = !paused;
    this.textContent = paused ? 'Resume' : 'Pause';
  });

  document.getElementById('btn-clear').addEventListener('click', () => {
    logEntries = [];
    logContainer.innerHTML = '';
    updateLogCount();
  });

  connectWs();

  // --- Resources ---
  const resContainer = document.getElementById('resources-container');

  async function loadResources() {
    try {
      const [resResp, statResp] = await Promise.all([
        fetch(BASE + '/_ldk/resources'), fetch(BASE + '/_ldk/status')
      ]);
      resourceData = await resResp.json();
      statusData = await statResp.json();
      renderResources();
    } catch(err) {
      resContainer.innerHTML = '<div class="empty-state">Failed to load resources: ' +
        esc(err.message) + '</div>';
    }
  }

  let invokeContexts = [];

  function renderResources() {
    if (!resourceData || !resourceData.services) {
      resContainer.innerHTML = '<div class="empty-state">No resources found.</div>';
      return;
    }
    invokeContexts = [];
    const provHealth = {};
    if (statusData && statusData.providers) {
      statusData.providers.forEach(p => { provHealth[p.name] = p.healthy; });
    }
    let html = '';
    for (const [svc, info] of Object.entries(resourceData.services)) {
      const healthy = provHealth[svc];
      const hClass = healthy === true ? 'healthy' : healthy === false ? 'unhealthy' : '';
      const hText = healthy === true ? 'healthy' : healthy === false ? 'unhealthy' : '';
      html += '<div class="svc-group">';
      html += '<div class="svc-header" data-toggle="svc">';
      html += '<span class="arrow">&#9654;</span> ';
      html += '<span class="svc-name">' + esc(svc) + '</span>';
      html += '<span class="svc-port">:' + (info.port || '?') + '</span>';
      if (hText) html += '<span class="svc-health ' + hClass + '">' + hText + '</span>';
      html += '</div>';
      html += '<div class="svc-body">';
      if (info.resources && info.resources.length) {
        info.resources.forEach(res => {
          const name = res.name || res.path || '(unnamed)';
          html += '<div class="resource-row">';
          html += '<span class="res-name">' + esc(name) + '</span>';
          getOperations(svc, res).forEach(op => {
            const idx = invokeContexts.length;
            invokeContexts.push({
              service: svc, port: info.port, resource: res, operation: op.name
            });
            html += '<button data-invoke="' + idx + '">' + esc(op.name) + '</button>';
          });
          html += '</div>';
        });
      } else {
        html += '<div class="resource-row">';
        html += '<span class="res-name" style="color:var(--fg2)">No resources</span>';
        html += '</div>';
      }
      html += '</div></div>';
    }
    resContainer.innerHTML = html || '<div class="empty-state">No services running.</div>';
  }

  // Event delegation for resource panel clicks
  resContainer.addEventListener('click', function(e) {
    const toggle = e.target.closest('[data-toggle="svc"]');
    if (toggle) {
      const arrow = toggle.querySelector('.arrow');
      if (arrow) arrow.classList.toggle('open');
      const body = toggle.nextElementSibling;
      if (body) body.style.display = body.style.display === 'none' ? '' : 'none';
      return;
    }
    const btn = e.target.closest('[data-invoke]');
    if (btn) {
      const idx = parseInt(btn.dataset.invoke, 10);
      const ctx = invokeContexts[idx];
      if (ctx) openInvoke(ctx);
    }
  });

  document.getElementById('btn-refresh').addEventListener('click', loadResources);

  function getOperations(svc, res) {
    switch(svc) {
      case 'dynamodb': return [
        {name:'Scan'},{name:'GetItem'},{name:'PutItem'},{name:'DeleteItem'}
      ];
      case 'sqs': return [
        {name:'SendMessage'},{name:'ReceiveMessage'},{name:'PurgeQueue'}
      ];
      case 's3': return [
        {name:'ListObjects'},{name:'GetObject'},{name:'PutObject'},{name:'DeleteObject'}
      ];
      case 'sns': return [{name:'Publish'},{name:'ListSubscriptions'}];
      case 'events': return [{name:'PutEvents'},{name:'ListRules'}];
      case 'stepfunctions': return [{name:'StartExecution'},{name:'ListExecutions'}];
      case 'cognito-idp': return [{name:'ListUsers'}];
      case 'apigateway': return [{name:'TestInvoke'}];
      default: return [];
    }
  }

  // --- Invoke ---
  function openInvoke(ctx) {
    document.querySelectorAll('.tab').forEach(b => b.classList.remove('active'));
    document.querySelectorAll('.panel').forEach(p => p.classList.remove('active'));
    document.querySelector('[data-tab="invoke"]').classList.add('active');
    document.getElementById('invoke').classList.add('active');
    renderInvokeForm(ctx);
  }

  function renderInvokeForm(ctx) {
    const ic = document.getElementById('invoke-content');
    const svc = ctx.service;
    const op = ctx.operation;
    const res = ctx.resource;
    const port = ctx.port;
    const resName = res.name || res.path || '';

    let fieldsHtml = '';
    fieldsHtml += buildInvokeFields(svc, op, res);

    ic.innerHTML =
      '<div class="invoke-header">' +
        '<button id="btn-invoke-back">&#8592; Back</button>' +
        '<strong>' + esc(svc.toUpperCase()) + '</strong> &rarr; ' +
        '<strong>' + esc(op) + '</strong> on <em>' + esc(resName) + '</em>' +
      '</div>' +
      '<div class="invoke-form" id="invoke-form">' + fieldsHtml +
        '<div class="btn-row">' +
          '<button class="btn-exec" id="btn-invoke-exec">Execute</button>' +
        '</div>' +
      '</div>' +
      '<div id="invoke-result" style="display:none"></div>';

    document.getElementById('btn-invoke-back').addEventListener('click', () => {
      document.querySelector('[data-tab="resources"]').click();
    });
    document.getElementById('btn-invoke-exec').addEventListener('click', () => {
      executeInvoke(ctx);
    });
  }

  function buildInvokeFields(svc, op, res) {
    var h = '';
    switch(svc) {
      case 'dynamodb':
        if (op === 'Scan') return '';
        if (op === 'GetItem' || op === 'DeleteItem') {
          h += '<label>Key (JSON)</label>';
          h += '<textarea id="f-key"></textarea>';
          return h;
        }
        if (op === 'PutItem') {
          h += '<label>Item (JSON)</label>';
          h += '<textarea id="f-item"></textarea>';
          return h;
        }
        return '';
      case 'sqs':
        if (op === 'SendMessage') {
          h += '<label>Message Body</label>';
          h += '<textarea id="f-body"></textarea>';
          return h;
        }
        return '';
      case 's3':
        if (op === 'GetObject' || op === 'DeleteObject') {
          h += '<label>Object Key</label>';
          h += '<input id="f-key" placeholder="path/to/object.txt">';
          return h;
        }
        if (op === 'PutObject') {
          h += '<label>Object Key</label>';
          h += '<input id="f-key" placeholder="path/to/object.txt">';
          h += '<label>Body</label>';
          h += '<textarea id="f-body"></textarea>';
          return h;
        }
        return '';
      case 'sns':
        if (op === 'Publish') {
          h += '<label>Message</label>';
          h += '<textarea id="f-body"></textarea>';
          h += '<label>Subject (optional)</label>';
          h += '<input id="f-subject">';
          return h;
        }
        return '';
      case 'events':
        if (op === 'PutEvents') {
          h += '<label>Event Entry (JSON)</label>';
          h += '<textarea id="f-body"></textarea>';
          return h;
        }
        return '';
      case 'stepfunctions':
        if (op === 'StartExecution') {
          h += '<label>Input (JSON)</label>';
          h += '<textarea id="f-body" placeholder="{}"></textarea>';
          return h;
        }
        return '';
      case 'apigateway':
        h += '<label>Method</label>';
        h += '<input id="f-method" value="' + esc(res.method||'GET') + '">';
        h += '<label>Path</label>';
        h += '<input id="f-path" value="' + esc(res.path||'/') + '">';
        h += '<label>Body (optional)</label>';
        h += '<textarea id="f-body"></textarea>';
        return h;
      default: return '';
    }
  }

  async function executeInvoke(ctx) {
    const resultEl = document.getElementById('invoke-result');
    resultEl.style.display = 'block';
    resultEl.className = '';
    resultEl.textContent = 'Executing...';

    try {
      const req = buildServiceRequest(ctx);
      const resp = await fetch(BASE + '/_ldk/service-proxy', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify(req)
      });
      const data = await resp.json();
      resultEl.id = 'invoke-result';
      if (data.status >= 400) {
        resultEl.className = 'error';
        resultEl.id = 'invoke-result';
      }
      let bodyText = data.body || '';
      try { bodyText = JSON.stringify(JSON.parse(bodyText), null, 2); } catch(_) {}
      resultEl.textContent = 'Status: ' + data.status + '\\n\\n' + bodyText;
    } catch(err) {
      resultEl.className = 'error';
      resultEl.id = 'invoke-result';
      resultEl.textContent = 'Error: ' + err.message;
    }
  }

  function buildServiceRequest(ctx) {
    const svc = ctx.service;
    const op = ctx.operation;
    const res = ctx.resource;
    const port = ctx.port;
    const base = 'http://localhost:' + port;

    switch(svc) {
      case 'dynamodb': {
        const body = {};
        body.TableName = res.name;
        if (op === 'GetItem') body.Key = JSON.parse(val('f-key') || '{}');
        if (op === 'PutItem') body.Item = JSON.parse(val('f-item') || '{}');
        if (op === 'DeleteItem') body.Key = JSON.parse(val('f-key') || '{}');
        return {method:'POST', url:base+'/', headers:{
          'X-Amz-Target':'DynamoDB_20120810.'+op,
          'Content-Type':'application/x-amz-json-1.0'
        }, body:JSON.stringify(body)};
      }
      case 'sqs': {
        const qurl = res.queue_url || (base+'/000000000000/'+res.name);
        let params = 'Action='+op+'&QueueUrl='+encodeURIComponent(qurl);
        if (op === 'SendMessage') params += '&MessageBody='+encodeURIComponent(val('f-body')||'');
        return {method:'POST', url:base+'/', headers:{
          'Content-Type':'application/x-www-form-urlencoded'
        }, body:params};
      }
      case 's3': {
        const bucket = res.name;
        if (op === 'ListObjects')
          return {method:'GET', url:base+'/'+bucket+'?list-type=2', headers:{}, body:''};
        if (op === 'GetObject')
          return {method:'GET', url:base+'/'+bucket+'/'+val('f-key'), headers:{}, body:''};
        if (op === 'PutObject')
          return {method:'PUT', url:base+'/'+bucket+'/'+val('f-key'),
                  headers:{'Content-Type':'application/octet-stream'}, body:val('f-body')||''};
        if (op === 'DeleteObject')
          return {method:'DELETE', url:base+'/'+bucket+'/'+val('f-key'), headers:{}, body:''};
        break;
      }
      case 'sns': {
        const arn = res.arn || '';
        let params = 'Action='+op+'&TopicArn='+encodeURIComponent(arn);
        if (op === 'Publish') {
          params += '&Message='+encodeURIComponent(val('f-body')||'');
          const subj = val('f-subject');
          if (subj) params += '&Subject='+encodeURIComponent(subj);
        }
        return {method:'POST', url:base+'/', headers:{
          'Content-Type':'application/x-www-form-urlencoded'
        }, body:params};
      }
      case 'events': {
        let body = {};
        if (op === 'PutEvents') {
          let entry = JSON.parse(val('f-body')||'{}');
          if (!entry.EventBusName) entry.EventBusName = res.arn || res.name;
          body = {Entries:[entry]};
        } else if (op === 'ListRules') {
          body = {EventBusName: res.arn || res.name};
        }
        return {method:'POST', url:base+'/', headers:{
          'X-Amz-Target':'AWSEvents.'+op,
          'Content-Type':'application/x-amz-json-1.1'
        }, body:JSON.stringify(body)};
      }
      case 'stepfunctions': {
        let body = {};
        const arn = res.arn || '';
        if (op === 'StartExecution')
          body = {stateMachineArn:arn, input:val('f-body')||'{}'};
        else if (op === 'ListExecutions')
          body = {stateMachineArn:arn};
        return {method:'POST', url:base+'/', headers:{
          'X-Amz-Target':'AWSStepFunctions.'+op,
          'Content-Type':'application/x-amz-json-1.0'
        }, body:JSON.stringify(body)};
      }
      case 'cognito-idp': {
        const poolId = res.user_pool_id || '';
        let body = {UserPoolId:poolId};
        return {method:'POST', url:base+'/', headers:{
          'X-Amz-Target':'AWSCognitoIdentityProviderService.'+op,
          'Content-Type':'application/x-amz-json-1.1'
        }, body:JSON.stringify(body)};
      }
      case 'apigateway': {
        const method = val('f-method') || 'GET';
        const path = val('f-path') || '/';
        const body = val('f-body') || '';
        return {method:method, url:base+path,
          headers:{'Content-Type':'application/json'}, body:body};
      }
    }
    return {method:'GET', url:base+'/', headers:{}, body:''};
  }

  // --- Helpers ---
  function val(id) {
    const el = document.getElementById(id);
    return el ? el.value : '';
  }

  function esc(s) {
    const d = document.createElement('div');
    d.textContent = s;
    return d.innerHTML;
  }

})();
</script>
</body>
</html>
"""


def get_dashboard_html() -> HTMLResponse:
    """Return the LDK dashboard as a self-contained HTML page."""
    return HTMLResponse(content=_DASHBOARD_HTML)
