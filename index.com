<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Bitácora de Aprendizaje</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500;700&display=swap" rel="stylesheet">
<style>
  :root{
    --bg:#1B2027;
    --bg-soft:#20262F;
    --surface:#242B35;
    --surface-2:#2A323D;
    --ink:#ECE7DA;
    --ink-dim:#9BA3AF;
    --ink-faint:#6B7280;
    --amber:#FFB454;
    --amber-soft:rgba(255,180,84,0.16);
    --amber-glow:rgba(255,180,84,0.55);
    --line:#3A4250;
    --danger:#E2675A;
    --danger-soft:rgba(226,103,90,0.14);
    --radius:10px;
    --mono:'JetBrains Mono','SFMono-Regular',Consolas,monospace;
    --sans:'Inter',-apple-system,sans-serif;
  }
  *{box-sizing:border-box;}
  html,body{margin:0;padding:0;}
  body{
    background-color:var(--bg);
    background-image:
      linear-gradient(rgba(255,255,255,0.035) 1px, transparent 1px),
      linear-gradient(90deg, rgba(255,255,255,0.035) 1px, transparent 1px);
    background-size:24px 24px;
    color:var(--ink);
    font-family:var(--sans);
    line-height:1.5;
  }
  .app{
    max-width:720px;
    margin:0 auto;
    padding:28px 18px 60px;
  }
  header{
    margin-bottom:22px;
  }
  .eyebrow{
    font-family:var(--mono);
    font-size:11px;
    letter-spacing:2px;
    color:var(--amber);
    text-transform:uppercase;
    margin:0 0 6px;
  }
  h1{
    font-family:var(--mono);
    font-size:26px;
    font-weight:700;
    letter-spacing:-0.5px;
    margin:0 0 6px;
    color:var(--ink);
  }
  .subtitle{
    font-size:14.5px;
    color:var(--ink-dim);
    font-style:italic;
    margin:0;
  }

  .stats{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:10px;
    margin:22px 0;
  }
  .stat{
    background:var(--surface);
    border:1px solid var(--line);
    border-radius:var(--radius);
    padding:13px 10px;
    text-align:center;
  }
  .stat .num{
    font-family:var(--mono);
    font-size:22px;
    font-weight:700;
    color:var(--amber);
    display:block;
  }
  .stat .lbl{
    font-size:10.5px;
    letter-spacing:0.5px;
    text-transform:uppercase;
    color:var(--ink-faint);
    display:block;
    margin-top:3px;
  }

  .panel{
    background:var(--surface);
    border:1px solid var(--line);
    border-radius:var(--radius);
    padding:18px;
    margin-bottom:18px;
  }
  .panel h2{
    font-family:var(--mono);
    font-size:13px;
    letter-spacing:1px;
    text-transform:uppercase;
    color:var(--ink-dim);
    margin:0 0 14px;
    display:flex;
    align-items:center;
    gap:8px;
  }
  .panel h2::before{
    content:'';
    width:6px;height:6px;
    border-radius:50%;
    background:var(--amber);
    box-shadow:0 0 6px var(--amber-glow);
    display:inline-block;
  }

  .field{margin-bottom:14px;}
  .field label{
    display:block;
    font-size:11.5px;
    letter-spacing:0.4px;
    text-transform:uppercase;
    color:var(--ink-faint);
    margin-bottom:6px;
    font-family:var(--mono);
  }
  .row2{display:grid; grid-template-columns:1fr 1fr; gap:12px;}
  input[type="text"], input[type="date"], textarea{
    width:100%;
    background:var(--surface-2);
    border:1px solid var(--line);
    border-radius:7px;
    color:var(--ink);
    font-family:var(--sans);
    font-size:14px;
    padding:9px 10px;
    outline:none;
    transition:border-color .15s;
  }
  input[type="text"]:focus, input[type="date"]:focus, textarea:focus{
    border-color:var(--amber);
  }
  textarea{resize:vertical; min-height:54px;}
  input[type="range"]{
    width:100%;
    accent-color:var(--amber);
  }
  .rating-row{display:flex; align-items:center; gap:12px;}
  .rating-row input[type="range"]{flex:1;}
  .rating-val{
    font-family:var(--mono);
    font-weight:700;
    font-size:18px;
    color:var(--amber);
    min-width:38px;
    text-align:center;
  }

  .btn{
    font-family:var(--mono);
    font-size:12.5px;
    letter-spacing:1px;
    text-transform:uppercase;
    font-weight:700;
    border:none;
    border-radius:7px;
    padding:11px 18px;
    cursor:pointer;
    transition:opacity .15s, transform .1s;
  }
  .btn:active{transform:scale(0.98);}
  .btn-primary{
    background:var(--amber);
    color:#1B1404;
  }
  .btn-primary:hover{opacity:0.9;}
  .btn-ghost{
    background:transparent;
    color:var(--ink-faint);
    border:1px solid var(--line);
  }
  .btn-danger{
    background:var(--danger-soft);
    color:var(--danger);
    border:1px solid var(--danger);
  }

  .form-footer{
    display:flex;
    align-items:center;
    justify-content:space-between;
    margin-top:6px;
  }
  .status{
    font-size:12.5px;
    color:var(--ink-faint);
    font-family:var(--mono);
    min-height:16px;
  }
  .status.err{color:var(--danger);}
  .status.ok{color:var(--amber);}

  .chart-empty{
    color:var(--ink-faint);
    font-size:13.5px;
    text-align:center;
    padding:30px 10px;
    font-style:italic;
  }
  svg text{font-family:var(--mono); fill:var(--ink-faint);}

  .log{display:flex; flex-direction:column; gap:10px;}
  .entry{
    background:var(--surface);
    border:1px solid var(--line);
    border-radius:var(--radius);
    padding:14px 16px;
  }
  .entry-top{
    display:flex;
    justify-content:space-between;
    align-items:flex-start;
    gap:10px;
    margin-bottom:8px;
  }
  .entry-date{
    font-family:var(--mono);
    font-size:11.5px;
    color:var(--ink-faint);
  }
  .entry-tema{
    font-size:15.5px;
    font-weight:600;
    color:var(--ink);
    margin:2px 0 0;
  }
  .entry-metodo{
    display:inline-block;
    margin-top:5px;
    font-family:var(--mono);
    font-size:10.5px;
    letter-spacing:0.4px;
    text-transform:uppercase;
    color:var(--ink-dim);
    border:1px solid var(--line);
    border-radius:5px;
    padding:2px 7px;
  }
  .rating-badge{
    font-family:var(--mono);
    font-weight:700;
    font-size:14px;
    color:var(--amber);
    border:1.5px solid var(--amber);
    border-radius:50%;
    width:34px;height:34px;
    display:flex;
    align-items:center;
    justify-content:center;
    flex-shrink:0;
    box-shadow:0 0 8px var(--amber-soft);
  }
  .entry-note{margin:8px 0 0;}
  .entry-note .nl{
    font-family:var(--mono);
    font-size:10px;
    letter-spacing:0.5px;
    text-transform:uppercase;
    color:var(--ink-faint);
    display:block;
    margin-bottom:2px;
  }
  .entry-note p{
    margin:0;
    font-size:13.5px;
    color:var(--ink-dim);
  }
  .entry-actions{
    margin-top:10px;
    display:flex;
    justify-content:flex-end;
    gap:8px;
  }
  .link-btn{
    background:none;
    border:none;
    font-family:var(--mono);
    font-size:11px;
    letter-spacing:0.5px;
    text-transform:uppercase;
    color:var(--ink-faint);
    cursor:pointer;
    padding:4px 6px;
  }
  .link-btn:hover{color:var(--danger);}
  .empty-log{
    color:var(--ink-faint);
    font-style:italic;
    font-size:13.5px;
    text-align:center;
    padding:20px;
  }

  .reset-line{
    text-align:center;
    margin-top:26px;
  }
  .reset-line button{
    background:none;
    border:none;
    font-family:var(--mono);
    font-size:10.5px;
    color:var(--ink-faint);
    text-decoration:underline;
    cursor:pointer;
  }

  @media (max-width:480px){
    .row2{grid-template-columns:1fr;}
    h1{font-size:22px;}
  }
</style>
</head>
<body>
<div class="app">

  <header>
    <p class="eyebrow">Bitácora · experimentos contigo mismo</p>
    <h1>Cómo aprendo yo</h1>
    <p class="subtitle">Un registro corto cada vez que estudies. Con el tiempo, los patrones aparecen solos.</p>
  </header>

  <section class="stats" id="stats"></section>

  <section class="panel">
    <h2>Nueva entrada</h2>
    <div class="row2">
      <div class="field">
        <label for="f-date">Fecha</label>
        <input type="date" id="f-date">
      </div>
      <div class="field">
        <label for="f-metodo">Método usado</label>
        <input type="text" id="f-metodo" placeholder="ej. recuerdo activo, Feynman...">
      </div>
    </div>
    <div class="field">
      <label for="f-tema">Tema que estudiaste</label>
      <input type="text" id="f-tema" placeholder="ej. AHPL: copia de memoria">
    </div>
    <div class="field">
      <label for="f-rating">¿Qué tan bien lo entendiste, en realidad?</label>
      <div class="rating-row">
        <input type="range" id="f-rating" min="1" max="10" value="5">
        <span class="rating-val" id="f-rating-val">5</span>
      </div>
    </div>
    <div class="field">
      <label for="f-ayudo">¿Qué hiciste que ayudó?</label>
      <textarea id="f-ayudo" placeholder="ej. expliqué el tema en voz alta sin ver mis notas"></textarea>
    </div>
    <div class="field">
      <label for="f-no">¿Qué no funcionó o te distrajo?</label>
      <textarea id="f-no" placeholder="ej. estudié de noche, me costó concentrarme"></textarea>
    </div>
    <div class="form-footer">
      <button class="btn btn-primary" onclick="addEntry()">Guardar entrada</button>
      <span class="status" id="status"></span>
    </div>
  </section>

  <section class="panel">
    <h2>Tendencia de comprensión</h2>
    <div id="chart-wrap"></div>
  </section>

  <section>
    <div id="log" class="log"></div>
  </section>

  <div class="reset-line">
    <button onclick="resetAll()">Borrar toda la bitácora</button>
  </div>

</div>

<script>
let entries = [];

function todayStr(){
  return new Date().toISOString().slice(0,10);
}

function fmtDate(d){
  const dt = new Date(d + 'T00:00:00');
  return dt.toLocaleDateString('es-ES', {day:'2-digit', month:'short'});
}

async function loadEntries(){
  try{
    const result = await window.storage.get('learning-log', false);
    entries = result ? JSON.parse(result.value) : [];
  }catch(e){
    entries = [];
  }
  document.getElementById('f-date').value = todayStr();
  renderAll();
}

async function persist(){
  try{
    await window.storage.set('learning-log', JSON.stringify(entries), false);
  }catch(e){
    showStatus('No se pudo guardar. Intenta de nuevo.', true);
  }
}

function showStatus(msg, isErr){
  const el = document.getElementById('status');
  el.textContent = msg;
  el.className = 'status ' + (isErr ? 'err' : 'ok');
  if(!isErr){
    setTimeout(()=>{ if(el.textContent === msg) el.textContent=''; }, 2500);
  }
}

function addEntry(){
  const date = document.getElementById('f-date').value || todayStr();
  const tema = document.getElementById('f-tema').value.trim();
  const metodo = document.getElementById('f-metodo').value.trim();
  const rating = parseInt(document.getElementById('f-rating').value, 10);
  const ayudo = document.getElementById('f-ayudo').value.trim();
  const noFunciono = document.getElementById('f-no').value.trim();

  if(!tema){
    showStatus('Escribe qué tema estudiaste.', true);
    return;
  }

  entries.push({
    id: Date.now() + '-' + Math.random().toString(36).slice(2,7),
    date, tema, metodo, rating, ayudo, noFunciono
  });

  persist();
  clearForm();
  renderAll();
  showStatus('Entrada guardada ✓');
}

function clearForm(){
  document.getElementById('f-tema').value = '';
  document.getElementById('f-metodo').value = '';
  document.getElementById('f-rating').value = 5;
  document.getElementById('f-rating-val').textContent = '5';
  document.getElementById('f-ayudo').value = '';
  document.getElementById('f-no').value = '';
  document.getElementById('f-date').value = todayStr();
}

let confirmingId = null;
function askDelete(id){
  confirmingId = id;
  renderLog();
}
function cancelDelete(){
  confirmingId = null;
  renderLog();
}
function deleteEntry(id){
  entries = entries.filter(e => e.id !== id);
  confirmingId = null;
  persist();
  renderAll();
}

async function resetAll(){
  if(confirmingResetAll){
    entries = [];
    try{ await window.storage.set('learning-log', JSON.stringify(entries), false); }catch(e){}
    confirmingResetAll = false;
    renderAll();
  }else{
    confirmingResetAll = true;
    showStatus('Pulsa otra vez para confirmar el borrado total.', true);
    setTimeout(()=>{ confirmingResetAll = false; }, 4000);
  }
}
let confirmingResetAll = false;

function computeStreak(){
  const dates = new Set(entries.map(e => e.date));
  let cursor = new Date();
  const fmt = d => d.toISOString().slice(0,10);
  if(!dates.has(fmt(cursor))){
    cursor.setDate(cursor.getDate()-1);
  }
  let streak = 0;
  while(dates.has(fmt(cursor))){
    streak++;
    cursor.setDate(cursor.getDate()-1);
  }
  return streak;
}

function renderStats(){
  const total = entries.length;
  const avg = total ? (entries.reduce((s,e)=>s+e.rating,0)/total).toFixed(1) : '—';
  const streak = computeStreak();
  document.getElementById('stats').innerHTML = `
    <div class="stat"><span class="num">${total}</span><span class="lbl">Entradas</span></div>
    <div class="stat"><span class="num">${streak}</span><span class="lbl">Racha (días)</span></div>
    <div class="stat"><span class="num">${avg}</span><span class="lbl">Promedio</span></div>
  `;
}

function renderChart(){
  const wrap = document.getElementById('chart-wrap');
  if(entries.length === 0){
    wrap.innerHTML = '<div class="chart-empty">Aún no hay datos. Tu primera entrada empieza la curva.</div>';
    return;
  }

  const sorted = [...entries].sort((a,b) => (a.date + a.id).localeCompare(b.date + b.id));
  const n = sorted.length;
  const W = 600, H = 220, padL = 30, padR = 14, padT = 14, padB = 30;
  const plotW = W - padL - padR;
  const plotH = H - padT - padB;

  const xAt = i => n <= 1 ? padL + plotW/2 : padL + (i/(n-1)) * plotW;
  const yAt = r => padT + plotH - ((r-1)/9) * plotH;

  let gridLines = '';
  [1,3,5,7,9].forEach(r => {
    const y = yAt(r);
    gridLines += `<line x1="${padL}" y1="${y}" x2="${W-padR}" y2="${y}" stroke="rgba(255,255,255,0.06)" stroke-width="1"/>`;
    gridLines += `<text x="${padL-8}" y="${y+3}" font-size="9" text-anchor="end">${r}</text>`;
  });

  let tickIdx;
  if(n <= 8){
    tickIdx = [...Array(n).keys()];
  }else{
    tickIdx = [...new Set([0, Math.floor(n/4), Math.floor(n/2), Math.floor(3*n/4), n-1])];
  }
  let xLabels = '';
  tickIdx.forEach(i => {
    xLabels += `<text x="${xAt(i)}" y="${H-8}" font-size="9" text-anchor="middle">${fmtDate(sorted[i].date)}</text>`;
  });

  const points = sorted.map((e,i) => `${xAt(i)},${yAt(e.rating)}`).join(' ');

  let circles = '';
  sorted.forEach((e,i) => {
    circles += `<circle cx="${xAt(i)}" cy="${yAt(e.rating)}" r="4" fill="#FFB454" filter="url(#glow)">
      <title>${e.date} · ${escapeXml(e.tema)}: ${e.rating}/10</title>
    </circle>`;
  });

  const polyline = n > 1
    ? `<polyline points="${points}" fill="none" stroke="#FFB454" stroke-width="2" filter="url(#glow)"/>`
    : '';

  wrap.innerHTML = `
    <svg viewBox="0 0 ${W} ${H}" style="width:100%; height:auto; background:#1B2027; border-radius:7px;">
      <defs>
        <filter id="glow" x="-50%" y="-50%" width="200%" height="200%">
          <feGaussianBlur stdDeviation="2.2" result="blur"/>
          <feMerge>
            <feMergeNode in="blur"/>
            <feMergeNode in="SourceGraphic"/>
          </feMerge>
        </filter>
      </defs>
      ${gridLines}
      ${xLabels}
      ${polyline}
      ${circles}
    </svg>
  `;
}

function escapeXml(s){
  return String(s).replace(/[<>&"']/g, c => ({'<':'&lt;','>':'&gt;','&':'&amp;','"':'&quot;',"'":'&apos;'}[c]));
}

function renderLog(){
  const el = document.getElementById('log');
  if(entries.length === 0){
    el.innerHTML = '<div class="empty-log">Tu bitácora está vacía. Registra tu primer experimento arriba.</div>';
    return;
  }
  const sorted = [...entries].sort((a,b) => (b.date + b.id).localeCompare(a.date + a.id));
  el.innerHTML = sorted.map(e => `
    <div class="entry">
      <div class="entry-top">
        <div>
          <span class="entry-date">${fmtDate(e.date)}</span>
          <p class="entry-tema">${escapeXml(e.tema)}</p>
          ${e.metodo ? `<span class="entry-metodo">${escapeXml(e.metodo)}</span>` : ''}
        </div>
        <div class="rating-badge">${e.rating}</div>
      </div>
      ${e.ayudo ? `<div class="entry-note"><span class="nl">Ayudó</span><p>${escapeXml(e.ayudo)}</p></div>` : ''}
      ${e.noFunciono ? `<div class="entry-note"><span class="nl">No funcionó</span><p>${escapeXml(e.noFunciono)}</p></div>` : ''}
      <div class="entry-actions">
        ${confirmingId === e.id
          ? `<button class="link-btn" onclick="cancelDelete()">cancelar</button><button class="link-btn" style="color:var(--danger)" onclick="deleteEntry('${e.id}')">confirmar borrado</button>`
          : `<button class="link-btn" onclick="askDelete('${e.id}')">eliminar</button>`
        }
      </div>
    </div>
  `).join('');
}

function renderAll(){
  renderStats();
  renderChart();
  renderLog();
}

document.getElementById('f-rating').addEventListener('input', e => {
  document.getElementById('f-rating-val').textContent = e.target.value;
});

loadEntries();
</script>
</body>
</html>
