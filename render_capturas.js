const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const CHROME_PATH = "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe";
const CAPTURAS_DIR = path.join(__dirname, 'capturas');

const cards = [
  {
    id: "captura1_drm_hardware",
    fileTitle: "BASES.PRG — Sistema Antipiratería / DRM por Hardware (1994)",
    badge: "Ingenio Técnico a los 17 años",
    codeHtml: `
<span class="com">////////////////////////////// rutina de seguridad</span>
<span class="kw">clear</span>
<span class="kw">run</span> <span class="str">vol&gt;mfl.txt</span>
<span class="kw">run</span> <span class="str">attrib +h mfl.txt</span>
<span class="kw">run</span> <span class="str">attrib -h mfl.dbf</span>
<span class="kw">clear</span>
cadena = <span class="fn">memoread</span>(<span class="str">"mfl.txt"</span>)
c1 = <span class="fn">val</span>(<span class="fn">substr</span>(cadena, <span class="num">81</span>, <span class="num">4</span>))
c2 = <span class="fn">val</span>(<span class="fn">substr</span>(cadena, <span class="num">86</span>, <span class="num">2</span>))
clave_ejecuta = c1 * c2

<span class="kw">if</span> .not. <span class="fn">file</span>(<span class="str">"mfl.dbf"</span>)
    <span class="kw">set color to</span> gr+/b
    <span class="kw">set cursor off</span>
    <span class="kw">@</span> <span class="num">12</span>,<span class="num">18</span> <span class="kw">say</span> <span class="str">"ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"</span>
    <span class="kw">@</span> <span class="num">13</span>,<span class="num">18</span> <span class="kw">say</span> <span class="str">"º    Si necesita una copia legal de este    º"</span>
    <span class="kw">@</span> <span class="num">14</span>,<span class="num">18</span> <span class="kw">say</span> <span class="str">"º sistema comuníquese al 740-5648 &gt;(Martín) º"</span>
    <span class="kw">@</span> <span class="num">15</span>,<span class="num">18</span> <span class="kw">say</span> <span class="str">"È1ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼"</span>
    <span class="fn">inkey</span>(<span class="num">0</span>)
    <span class="kw">quit</span>
<span class="kw">endif</span>

<span class="kw">use</span> mfl
contra = clave
<span class="kw">close databases</span>
<span class="kw">if</span> clave_ejecuta &lt;&gt; contra
    <span class="com">// Si el sistema fue copiado a otro disco rígido, se bloquea</span>
    <span class="kw">@</span> <span class="num">13</span>,<span class="num">18</span> <span class="kw">say</span> <span class="str">"º    Si necesita una copia legal de este    º"</span>
    <span class="kw">@</span> <span class="num">14</span>,<span class="num">18</span> <span class="kw">say</span> <span class="str">"º sistema comuníquese al 740-5648 &gt;(Martín) º"</span>
    <span class="fn">inkey</span>(<span class="num">0</span>)
    <span class="kw">quit</span>
<span class="kw">endif</span>
`
  },
  {
    id: "captura2_motor_alquileres",
    fileTitle: "ALQUIL.PRG — Núcleo Transaccional de Alquileres & Validación",
    badge: "Reglas de Negocio en Mostrador",
    codeHtml: `
<span class="com">// ALQUIL.PRG - Validación de socios y control de alquiler</span>
<span class="kw">select</span> <span class="num">2</span>  <span class="com">// MAESOC</span>
<span class="kw">@</span> <span class="num">22</span>,<span class="num">1</span> <span class="kw">say</span> <span class="str">"N° Socio:"</span> <span class="kw">get</span> nro_socio <span class="kw">picture</span> <span class="str">"99999"</span>
<span class="kw">read</span>
<span class="kw">seek</span> nro_socio
<span class="kw">if</span> <span class="fn">found</span>()
    <span class="kw">if</span> estsoc == <span class="str">"N"</span>
        <span class="kw">@</span> <span class="num">15</span>,<span class="num">10</span> <span class="kw">say</span> <span class="str">" ­ ATENCION --------&gt; Ese SOCIO esta inactivo "</span>
    <span class="kw">else</span>
        <span class="kw">@</span> <span class="num">23</span>,<span class="num">1</span>  <span class="kw">say</span> nomsoc <span class="kw">picture</span> <span class="str">"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"</span>
        <span class="kw">@</span> <span class="num">23</span>,<span class="num">31</span> <span class="kw">say</span> dirsoc <span class="kw">picture</span> <span class="str">"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"</span>
        <span class="kw">@</span> <span class="num">23</span>,<span class="num">70</span> <span class="kw">say</span> telsoc <span class="kw">picture</span> <span class="str">"!!!!!!!!!"</span>
        n_parche = nro_socio
    <span class="kw">endif</span>
<span class="kw">endif</span>

<span class="fn">deudores</span>()  <span class="com">// Auditoría inmediata de deuda previa antes de alquilar</span>
<span class="fn">devpen</span>()    <span class="com">// Comprobación de títulos pendientes de devolución</span>

<span class="kw">set key</span> K_F1 <span class="kw">to</span> ayu          <span class="com">// F1: Consulta rápida de catálogo</span>
<span class="kw">set key</span> K_F2 <span class="kw">to</span> devoluciones <span class="com">// F2: Devolución de cartuchos</span>
<span class="kw">set key</span> K_F5 <span class="kw">to</span> renglon      <span class="com">// F5: Borra renglón</span>
<span class="kw">set key</span> K_F8 <span class="kw">to</span> cierre       <span class="com">// F8: Cierre y liquidación final</span>

<span class="kw">function</span> <span class="fn">nosafa</span>(x)
    <span class="com">// Regla de integridad: el cliente no puede abonar más del total</span>
    <span class="kw">if</span> x &gt; sub_total
        <span class="kw">return</span> .f.
    <span class="kw">else</span>
        <span class="kw">return</span> .t.
    <span class="kw">endif</span>
`
  },
  {
    id: "captura3_tui_3d_engine",
    fileTitle: "FONDO.PRG & MENU.PRG — Motor Gráfico TUI con Sombras 3D",
    badge: "UX / Text UI en MS-DOS (1994)",
    codeHtml: `
<span class="com">// FONDO.PRG - Motor de relieve 3D y sombras en pantallas 80x25</span>
col = color; rec = recuadro; dob = doble; men = menuv
<span class="kw">set color to</span> w+/b+
<span class="kw">@</span> <span class="num">0</span>,<span class="num">0</span> <span class="kw">say</span> <span class="str">"Club de Video Juegos                                              "</span>

<span class="kw">if</span> men == <span class="num">1</span>
    <span class="kw">set color to</span> w+/&amp;color         <span class="com">// Borde superior e izquierdo (LUZ)</span>
    <span class="kw">@</span> <span class="num">7</span>,<span class="num">26</span>  <span class="kw">say</span> <span class="str">"ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"</span>
    <span class="kw">@</span> <span class="num">8</span>,<span class="num">26</span>  <span class="kw">say</span> <span class="str">"³"</span>
    <span class="kw">@</span> <span class="num">9</span>,<span class="num">26</span>  <span class="kw">say</span> <span class="str">"³"</span>
    <span class="kw">@</span> <span class="num">10</span>,<span class="num">26</span> <span class="kw">say</span> <span class="str">"³"</span>
    <span class="kw">@</span> <span class="num">11</span>,<span class="num">26</span> <span class="kw">say</span> <span class="str">"³"</span>
    <span class="kw">@</span> <span class="num">12</span>,<span class="num">26</span> <span class="kw">say</span> <span class="str">"³"</span>
    <span class="kw">@</span> <span class="num">13</span>,<span class="num">26</span> <span class="kw">say</span> <span class="str">"À"</span>
    
    <span class="kw">set color to</span> n/&amp;color          <span class="com">// Borde derecho e inferior (SOMBRA)</span>
    <span class="kw">@</span> <span class="num">7</span>,<span class="num">52</span>  <span class="kw">say</span> <span class="str">"¿"</span>
    <span class="kw">@</span> <span class="num">8</span>,<span class="num">52</span>  <span class="kw">say</span> <span class="str">"³"</span>
    <span class="kw">@</span> <span class="num">9</span>,<span class="num">52</span>  <span class="kw">say</span> <span class="str">"³"</span>
    <span class="kw">@</span> <span class="num">10</span>,<span class="num">52</span> <span class="kw">say</span> <span class="str">"³"</span>
    <span class="kw">@</span> <span class="num">11</span>,<span class="num">52</span> <span class="kw">say</span> <span class="str">"³"</span>
    <span class="kw">@</span> <span class="num">12</span>,<span class="num">52</span> <span class="kw">say</span> <span class="str">"³"</span>
    <span class="kw">@</span> <span class="num">13</span>,<span class="num">27</span> <span class="kw">say</span> <span class="str">"ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"</span>
<span class="kw">endif</span>

<span class="com">// MENU.PRG - Reloj en tiempo real actualizado segundo a segundo</span>
<span class="kw">do while</span> .t.
    <span class="kw">set color to</span> w+/b+
    <span class="kw">@</span> <span class="num">0</span>,<span class="num">50</span> <span class="kw">say</span> <span class="str">"Fecha:"</span>
    <span class="kw">@</span> <span class="num">0</span>,<span class="num">56</span> <span class="kw">say</span> <span class="fn">date</span>()
    <span class="kw">@</span> <span class="num">0</span>,<span class="num">67</span> <span class="kw">say</span> <span class="str">"Hora:"</span>
    <span class="kw">@</span> <span class="num">0</span>,<span class="num">72</span> <span class="kw">say</span> <span class="fn">time</span>()  <span class="com">// Reloj activo en cabecera</span>
    <span class="fn">inkey</span>()
<span class="kw">enddo</span>
`
  },
  {
    id: "captura4_y2k_cierre_historico",
    fileTitle: "y2k.prg & cierre.prg — +25.000 Registros & Parche Año 2000",
    badge: "Mantenimiento & Producción Real",
    codeHtml: `
<span class="com">// y2k.prg - Parche correctivo para el Efecto Año 2000</span>
<span class="kw">close databases</span>
<span class="kw">use</span> movdia
<span class="kw">set century on</span>
<span class="kw">set date french</span>

<span class="kw">go</span> <span class="num">25322</span>  <span class="com">// ¡Base con más de 25.000 operaciones reales registradas!</span>
<span class="kw">do while</span> .not. <span class="fn">eof</span>()
    <span class="kw">@</span> <span class="num">1</span>,<span class="num">1</span> <span class="kw">say</span> alquil
    <span class="kw">if</span> <span class="fn">year</span>(alquil) == <span class="num">1900</span>
        dia = <span class="fn">str</span>(<span class="fn">day</span>(alquil))
        mes = <span class="fn">str</span>(<span class="fn">month</span>(alquil))
        ano = <span class="fn">str</span>(<span class="num">2000</span>)
        auxiliar = <span class="fn">ctod</span>(dia + <span class="str">"/"</span> + mes + <span class="str">"/"</span> + ano)
        <span class="kw">replace</span> alquil <span class="kw">with</span> auxiliar
    <span class="kw">endif</span>
    <span class="kw">skip</span>
<span class="kw">enddo</span>

<span class="com">// cierre.prg - Migración periódica a histórico y compactación de disco</span>
<span class="kw">select</span> <span class="num">1</span>  <span class="com">// MOVDIA.DBF (operaciones del día)</span>
<span class="kw">select</span> <span class="num">2</span>  <span class="com">// HISDIA.DBF (histórico de movimientos)</span>
<span class="kw">do while</span> .not. <span class="fn">eof</span>()
    <span class="kw">select</span> <span class="num">2</span>
    <span class="kw">append blank</span>
    <span class="kw">replace</span> alquil <span class="kw">with</span> var_ALQUIL, codsoc <span class="kw">with</span> var_CODSOC ...
    <span class="kw">commit</span>
    <span class="kw">select</span> <span class="num">1</span>
    <span class="kw">delete</span>
    <span class="kw">skip</span>
<span class="kw">enddo</span>
<span class="kw">pack</span>  <span class="com">// Limpieza física de disco y reoptimización de velocidad en FAT16</span>
`
  }
];

const template = (card) => `<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    background: linear-gradient(135deg, #0f172a 0%, #1e1b4b 50%, #0f172a 100%);
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 30px;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
  }
  .card {
    background: #11111b;
    border-radius: 14px;
    box-shadow: 0 30px 60px -12px rgba(0, 0, 0, 0.7), 0 0 0 1px rgba(255, 255, 255, 0.1);
    width: 1000px;
    overflow: hidden;
  }
  .header {
    background: #181825;
    padding: 14px 20px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-bottom: 1px solid rgba(255, 255, 255, 0.08);
  }
  .dots {
    display: flex;
    gap: 8px;
  }
  .dot {
    width: 12px;
    height: 12px;
    border-radius: 50%;
  }
  .dot-red { background: #ff5f56; }
  .dot-yellow { background: #ffbd2e; }
  .dot-green { background: #27c93f; }
  .title {
    color: #cdd6f4;
    font-family: 'Consolas', 'Courier New', monospace;
    font-size: 14px;
    font-weight: 600;
    letter-spacing: 0.5px;
  }
  .badge {
    background: rgba(137, 180, 250, 0.15);
    color: #89b4fa;
    border: 1px solid rgba(137, 180, 250, 0.3);
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
  }
  pre {
    padding: 24px 28px;
    color: #cdd6f4;
    font-family: 'Consolas', 'Courier New', monospace;
    font-size: 15px;
    line-height: 1.55;
    overflow-x: hidden;
    tab-size: 4;
  }
  .kw { color: #f38ba8; font-weight: bold; }       /* Rosa/Rojo para palabras clave */
  .fn { color: #89b4fa; }                         /* Azul para funciones */
  .str { color: #a6e3a1; }                        /* Verde para strings */
  .com { color: #6c7086; font-style: italic; }    /* Gris para comentarios */
  .num { color: #fab387; }                        /* Naranja para números */
  .footer {
    background: #181825;
    padding: 10px 24px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-top: 1px solid rgba(255, 255, 255, 0.05);
    color: #a6adc8;
    font-size: 12px;
  }
  .brand {
    color: #f9e2af;
    font-weight: 600;
  }
</style>
</head>
<body>
  <div class="card">
    <div class="header">
      <div class="dots">
        <div class="dot dot-red"></div>
        <div class="dot dot-yellow"></div>
        <div class="dot dot-green"></div>
      </div>
      <div class="title">${card.fileTitle}</div>
      <div class="badge">${card.badge}</div>
    </div>
    <pre><code>${card.codeHtml.trim()}</code></pre>
    <div class="footer">
      <div>CA-Clipper 5.x • MS-DOS • 1994</div>
      <div class="brand">MFL Sistemas — Martín Lazo</div>
    </div>
  </div>
</body>
</html>`;

for (const card of cards) {
  const htmlPath = path.join(CAPTURAS_DIR, `${card.id}.html`);
  const pngPath = path.join(CAPTURAS_DIR, `${card.id}.png`);
  fs.writeFileSync(htmlPath, template(card), 'utf8');

  console.log(`Renderizando ${card.id}...`);
  const cmd = `"${CHROME_PATH}" --headless --disable-gpu --window-size=1080,820 --screenshot="${pngPath}" "${htmlPath}"`;
  execSync(cmd);
  
  // Limpiar HTML temporal
  fs.unlinkSync(htmlPath);
  console.log(`✓ Generada: ${pngPath}`);
}
console.log("¡Todas las capturas generadas con éxito!");
