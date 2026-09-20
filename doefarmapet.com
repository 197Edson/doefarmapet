<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DoeFarmaPet - Plataforma de Doação</title>
    <!-- Adicione seus estilos e FontAwesome aqui -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Estilos básicos de exemplo para o carrossel e layout funcionar */
        :root { --primary: #2c3e50; --accent: #27ae60; }
        body { font-family: Arial, sans-serif; margin: 0; background: #f4f7f6; }
        .hero { padding: 20px; }
        .dashboard-layout { display: flex; gap: 20px; }
        .sidebar { width: 250px; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
        .sidebar a { display: block; padding: 10px 15px; color: #333; text-decoration: none; margin-bottom: 5px; border-radius: 5px; }
        .sidebar a:hover { background: #f0f0f0; }
        .logo-container { display: flex; align-items: center; gap: 10px; font-weight: bold; margin-bottom: 20px; }
        .logo-container img { width: 40px; height: 40px; border-radius: 50%; }
        .content-area { flex: 1; }
        
        /* Estilos do Carrossel de Anúncios / Marcas Amigas */
        .carrossel-container { position: relative; overflow: hidden; width: 100%; max-width: 600px; border-radius: 10px; background: white; box-shadow: 0 4px 10px rgba(0,0,0,0.1); margin-bottom: 10px; }
        .carrossel-slides { display: flex; transition: transform 0.5s ease-in-out; }
        .card-iframe-slide { min-width: 100%; box-sizing: border-box; padding: 20px; background: #fff; text-align: center; }
        .link-oferta { display: inline-block; padding: 15px 25px; background: var(--accent); color: white; border-radius: 30px; text-decoration: none; font-weight: bold; transition: 0.2s; box-shadow: 0 4px 10px rgba(0,0,0,0.15); }
        .link-oferta:hover { opacity: 0.9; transform: translateY(-2px); }
        .btn-carrossel { position: absolute; top: 50%; transform: translateY(-50%); background: rgba(0,0,0,0.5); color: white; border: none; padding: 10px 15px; cursor: pointer; z-index: 10; border-radius: 50%; }
        .btn-carrossel.prev { left: 10px; }
        .btn-carrossel.next { right: 10px; }
        .dots-container { display: flex; justify-content: center; gap: 8px; margin-bottom: 25px; }
        .dot { width: 10px; height: 10px; background: #ccc; border-radius: 50%; display: inline-block; cursor: pointer; transition: 0.3s; }
        .dot.active { background: var(--accent); width: 25px; border-radius: 5px; }

        .grid-anuncios { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 15px; margin-top: 15px; }
        .card { background: white; padding: 15px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); text-align: center; }
        .img-produto { width: 100%; height: 150px; object-fit: cover; border-radius: 5px; }
        .rodape-projeto { margin-top: 40px; padding: 20px 0; text-align: center; color: #666; font-size: 0.9rem; border-top: 1px solid #ddd; }
        .btn-whatsapp { position: fixed; bottom: 20px; right: 20px; background: #25d366; color: white; padding: 12px 20px; border-radius: 30px; text-decoration: none; font-weight: bold; box-shadow: 0 4px 10px rgba(0,0,0,0.2); z-index: 1000; }
    </style>
</head>
<body>

<section class="hero">
    <div class="dashboard-layout">
        <nav class="sidebar">
            <a href="index.html" class="logo-container">
                <img src="https://tse3.mm.bing.net/th/id/OIP.SPw2GOqqPuW0LHY2L7od4gHaHa?pid=Api&P=0&h=180" alt="Logo DoeFarmaPet" referrerpolicy="no-referrer">
                <span>DOEFARMAPET</span>
            </a>
            
            <a href="saude.html" class="btn-sidebar"><i class="fa-solid fa-stethoscope"></i> Clínicas</a>
            <a href="parceiros.html" class="btn-sidebar"><i class="fa-solid fa-hand-holding-heart"></i> ONGs</a>
            <a href="painel.html" class="btn-sidebar"><i class="fa-solid fa-gauge"></i> Painel</a>
            <a href="login.html" class="btn-sidebar"><i class="fa-solid fa-user"></i> Conta</a>
        </nav>

        <div class="content-area">

            <!-- Mensagem de Alerta Estática Exemplo -->
            <div class="alert-message alert-success" style="padding: 10px; background: #d4edda; color: #155724; border-radius: 5px; margin-bottom: 15px;">✨ Bem-vindo à plataforma de doação!</div>

            <h1>Plataforma de Doação.</h1>
            <p class="missao">"O DoeFarmaPet é uma plataforma de doação gratuita de medicamentos veterinários que combate o desperdício conectando tutores e protetores para salvar vidas animais."</p>

            <form action="index.html" method="GET" style="display:flex; max-width: 500px; margin: 0 0 25px 0;">
                <input type="text" name="q" placeholder="Buscar medicamento..." style="padding:15px; flex:1; border-radius:25px 0 0 25px; border:1px solid #ccc; outline: none;">
                <button type="submit" style="padding:0 25px; border-radius:0 25px 25px 0; border:none; background:var(--accent); color:white; cursor:pointer;">Buscar</button>
            </form>

            <!-- === CARROSSEL DE MARCAS AMIGAS / ANÚNCIOS NO TOPO === -->
            <h2 class="titulo-secao" style="margin-top:0;"><i class="fa-solid fa-handshake"></i> Marcas Amigas</h2>
            <div class="carrossel-container">
                <button class="btn-carrossel prev" id="btnPrev"><i class="fa-solid fa-chevron-left"></i></button>
                <button class="btn-carrossel next" id="btnNext"><i class="fa-solid fa-chevron-right"></i></button>

                <div class="carrossel-slides" id="carrosselSlides">
                    <!-- Slide 1 de Propaganda -->
                    <div class="card-iframe-slide">
                        <p style="color: #666; margin-bottom: 15px; font-size: 0.9rem;">Publicidade Patrocinada</p>
                        <a href="https://exemplo.com/parceiro-1" target="_blank" class="link-oferta">
                            <i class="fa-solid fa-external-link"></i> PetShop Amigo Fiel
                        </a>
                    </div>
                    <!-- Slide 2 de Propaganda -->
                    <div class="card-iframe-slide">
                        <p style="color: #666; margin-bottom: 15px; font-size: 0.9rem;">Publicidade Patrocinada</p>
                        <a href="https://exemplo.com/parceiro-2" target="_blank" class="link-oferta">
                            <i class="fa-solid fa-external-link"></i> Farmácia Veterinária Saúde Animal
                        </a>
                    </div>
                    <!-- Slide 3 de Propaganda -->
                    <div class="card-iframe-slide">
                        <p style="color: #666; margin-bottom: 15px; font-size: 0.9rem;">Publicidade Patrocinada</p>
                        <a href="https://exemplo.com/parceiro-3" target="_blank" class="link-oferta">
                            <i class="fa-solid fa-external-link"></i> Rações Premium & Cia
                        </a>
                    </div>
                </div>
            </div>

            <div class="dots-container" id="dotsContainer">
                <span class="dot active" data-index="0"></span>
                <span class="dot" data-index="1"></span>
                <span class="dot" data-index="2"></span>
            </div>

            <!-- GRID DE ANÚNCIOS DE MEDICAMENTOS -->
            <h2 class="titulo-secao"><i class="fa-solid fa-pills"></i> Medicamentos Disponíveis</h2>
            <div class="grid-anuncios">
                <div class="card">
                    <img src="https://via.placeholder.com/200" class="img-produto" alt="Remédio Exemplo">
                    <h3>Vermífugo Exemplo</h3>
                    <a href="detalhes.html" style="display:block; margin-top:10px; background:var(--primary); color:white; padding:10px; border-radius:5px; text-decoration:none; text-align:center;">Ver detalhes</a>
                </div>
                <div class="card">
                    <img src="https://via.placeholder.com/200" class="img-produto" alt="Remédio Exemplo">
                    <h3>Antibiótico Pet</h3>
                    <a href="detalhes.html" style="display:block; margin-top:10px; background:var(--primary); color:white; padding:10px; border-radius:5px; text-decoration:none; text-align:center;">Ver detalhes</a>
                </div>
            </div>

            <!-- RODAPÉ INSTITUCIONAL -->
            <footer class="rodape-projeto">
                <p>© 2026 <strong>DoeFarmaPet</strong>. Todos os direitos reservados.</p>
                <p>Projeto desenvolvido no curso técnico de Desenvolvimento de Sistemas — Ginásio Pernambucano.</p>
                <p>Recife, Pernambuco.</p>
            </footer>

        </div>
    </div>
</section>

<a href="https://wa.me/5581993057487" class="btn-whatsapp" target="_blank"><i class="fa-brands fa-whatsapp"></i> Sugestão/Elogios</a>

<!-- === SCRIPT LÓGICA DO CARROSSEL === -->
<script>
document.addEventListener("DOMContentLoaded", function() {
    let indiceAtual = 0;
    const slides = document.getElementById('carrosselSlides');
    const dots = document.querySelectorAll('.dot');
    const totalSlides = dots.length;
    let timerCarrossel;

    function atualizarCarrossel() {
        if (!slides || totalSlides === 0) return;
        slides.style.transform = `translateX(-${indiceAtual * 100}%)`;
        dots.forEach((dot, index) => {
            dot.classList.toggle('active', index === indiceAtual);
        });
    }

    function mudarSlide(direcao) {
        if (totalSlides === 0) return;
        indiceAtual = (indiceAtual + direcao + totalSlides) % totalSlides;
        atualizarCarrossel();
        reiniciarTimer();
    }

    function irParaSlide(index) {
        if (totalSlides === 0) return;
        indiceAtual = index;
        atualizarCarrossel();
        reiniciarTimer();
    }

    function iniciarTimer() {
        if (totalSlides > 1) {
            timerCarrossel = setInterval(() => {
                mudarSlide(1);
            }, 6000);
        }
    }

    function reiniciarTimer() {
        clearInterval(timerCarrossel);
        iniciarTimer();
    }

    const btnPrev = document.getElementById('btnPrev');
    const btnNext = document.getElementById('btnNext');

    if (btnPrev) btnPrev.addEventListener('click', () => mudarSlide(-1));
    if (btnNext) btnNext.addEventListener('click', () => mudarSlide(1));

    dots.forEach(dot => {
        dot.addEventListener('click', function() {
            const index = parseInt(this.getAttribute('data-index'));
            irParaSlide(index);
        });
    });

    iniciarTimer();
});
</script>

</body>
</html>
