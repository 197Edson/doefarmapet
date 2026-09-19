<section class="hero">
    <div class="dashboard-layout">
        <nav class="sidebar">
            <a href="index.php" class="logo-container">
                <img src="https://tse3.mm.bing.net/th/id/OIP.SPw2GOqqPuW0LHY2L7od4gHaHa?pid=Api&P=0&h=180" alt="Logo DoeFarmaPet" referrerpolicy="no-referrer">
                <span>DOEFARMAPET</span>
            </a>
            
            <a href="saude.php" class="btn-sidebar"><i class="fa-solid fa-stethoscope"></i> Clínicas</a>
            <a href="parceiros.php" class="btn-sidebar"><i class="fa-solid fa-hand-holding-heart"></i> ONGs</a>
            <a href="painel.php" class="btn-sidebar"><i class="fa-solid fa-gauge"></i> Painel</a>
            
            <?php if (isset($_SESSION['usuario_id'])): ?>
                <a href="logout.php" class="btn-sidebar" style="color:#dc3545;"><i class="fa-solid fa-right-from-bracket"></i> Sair</a>
            <?php else: ?>
                <a href="login.php" class="btn-sidebar"><i class="fa-solid fa-user"></i> Conta</a>
            <?php endif; ?>
        </nav>

        <div class="content-area">
            
            <?php
            if (isset($_GET['status'])) {
                if ($_GET['status'] === 'sucesso') {
                    echo '<div class="alert-message alert-success">✨ Avaliação enviada com sucesso! Obrigado por ajudar a melhorar nossa comunidade.</div>';
                } elseif ($_GET['status'] === 'erro' || $_GET['status'] === 'erro_dados') {
                    echo '<div class="alert-message alert-error">❌ Ops! Não foi possível salvar sua avaliação. Por favor, tente novamente.</div>';
                }
            }
            ?>

            <h1>Plataforma de Doação.</h1>
            <p class="missao">"O DoeFarmaPet é uma plataforma de doação gratuita de medicamentos veterinários que combate o desperdício conectando tutores e protetores para salvar vidas animais."</p>

            <form action="index.php" method="GET" style="display:flex; max-width: 500px; margin: 0 0 25px 0;">
                <input type="text" name="q" value="<?= htmlspecialchars($busca) ?>" placeholder="Buscar medicamento..." style="padding:15px; flex:1; border-radius:25px 0 0 25px; border:none; outline: none;">
                <button type="submit" style="padding:0 25px; border-radius:0 25px 25px 0; border:none; background:var(--accent); color:white; cursor:pointer;">Buscar</button>
            </form>

            <!-- === CARROSSEL DE MARCAS AMIGAS NO TOPO === -->
            <?php if (!empty($marcas_amigas)): ?>
                <h2 class="titulo-secao" style="margin-top:0;"><i class="fa-solid fa-handshake"></i> Marcas Amigas</h2>
                <div class="carrossel-container">
                    <button class="btn-carrossel prev" id="btnPrev"><i class="fa-solid fa-chevron-left"></i></button>
                    <button class="btn-carrossel next" id="btnNext"><i class="fa-solid fa-chevron-right"></i></button>

                    <div class="carrossel-slides" id="carrosselSlides">
                        <?php foreach ($marcas_amigas as $marca): ?>
                            <div class="card-iframe-slide">
                                <iframe src="<?= htmlspecialchars($marca['url_iframe']) ?>" loading="lazy"></iframe>
                                <a href="<?= htmlspecialchars($marca['url_link']) ?>" target="_blank" class="link-oferta">
                                    <i class="fa-solid fa-external-link"></i> <?= htmlspecialchars($marca['titulo']) ?>
                                </a>
                            </div>
                        <?php endforeach; ?>
                    </div>
                </div>

                <div class="dots-container" id="dotsContainer">
                    <?php foreach ($marcas_amigas as $idx => $marca): ?>
                        <span class="dot <?= $idx === 0 ? 'active' : '' ?>" data-index="<?= $idx ?>"></span>
                    <?php endforeach; ?>
                </div>
            <?php endif; ?>

            <!-- GRID DE ANÚNCIOS -->
            <h2 class="titulo-secao"><i class="fa-solid fa-pills"></i> Medicamentos Disponíveis</h2>
            <div class="grid-anuncios">
                <?php if (empty($anuncios)): ?>
                    <p style="margin-top:20px;">Nenhum anúncio encontrado.</p>
                <?php else: ?>
                    <?php foreach ($anuncios as $a): ?>
                        <div class="card">
                            <img src="uploads/<?= htmlspecialchars($a['foto']) ?>" class="img-produto" onerror="this.src='https://via.placeholder.com/200'">
                            <h3><?= htmlspecialchars($a['titulo']) ?></h3>
                            <a href="detalhes.php?id=<?= $a['id'] ?>" style="display:block; margin-top:10px; background:var(--primary); color:white; padding:10px; border-radius:5px; text-decoration:none; text-align:center;">Ver detalhes</a>
                        </div>
                    <?php endforeach; ?>
                <?php endif; ?>
            </div>

            <!-- SEÇÃO DE AVALIAÇÕES -->
            <h2 class="titulo-secao">⭐ O que dizem sobre nós</h2>
            <div class="grid-avaliacoes" style="display: block;">
                <?php 
                try {
                    $total_avaliacoes = $pdo->query("SELECT COUNT(*) FROM avaliacoes")->fetchColumn();
                } catch (PDOException $e) {
                    $total_avaliacoes = 0;
                }

                if (empty($avaliacoes)): ?>
                    <p style="opacity: 0.8;">Nenhuma avaliação disponível ainda. Seja o primeiro a avaliar!</p>
                <?php else: 
                    $av = $avaliacoes[0]; 
                ?>
                    <div class="card-avaliacao" style="max-width: 500px; margin-bottom: 20px; position: relative;">
                        <div class="estrelas-ouro">
                            <?php
                            for ($i = 1; $i <= 5; $i++) {
                                echo ($i <= $av['nota']) ? '<i class="fa-solid fa-star"></i>' : '<i class="fa-regular fa-star"></i>';
                            }
                            ?>
                        </div>
                        <p class="comentario-texto" style="margin-bottom: 20px;">"<?= htmlspecialchars($av['comentario']) ?>"</p>
                        
                        <?php if ($total_avaliacoes > 1): ?>
                            <div style="border-top: 1px solid #e0e0e0; padding-top: 15px; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 10px;">
                                <span style="font-size: 0.85rem; color: #666;">
                                    Mais <?= $total_avaliacoes - 1 ?> pessoas avaliaram
                                </span>
                                <a href="avaliar.php" style="display: inline-block; background: var(--primary); color: white; padding: 8px 15px; border-radius: 20px; font-size: 0.85rem; font-weight: bold; text-decoration: none; box-shadow: 0 2px 5px rgba(0,0,0,0.1); transition: 0.2s;" onmouseover="this.style.background='var(--accent)'" onmouseout="this.style.background='var(--primary)'">
                                    <i class="fa-solid fa-comments"></i> Clique aqui para ver comentários (<?= $total_avaliacoes ?>)
                                </a>
                            </div>
                        <?php endif; ?>
                    </div>
                <?php endif; ?>
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

<!-- === SCRIPT LÓGICA CORRIGIDA DO CARROSSEL E PWA === -->
<script>
document.addEventListener("DOMContentLoaded", function() {
    let indiceAtual = 0;
    const slides = document.getElementById('carrosselSlides');
    const dots = document.querySelectorAll('.dot');
    const totalSlides = <?= count($marcas_amigas) ?>;
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

    // Atribuição dos eventos aos botões
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

/* Service Worker PWA */
if ('serviceWorker' in navigator) {
    window.addEventListener('load', function() {
        navigator.serviceWorker.register('/sw.js')
            .then(function(registration) {
                console.log('Service Worker registrado:', registration.scope);
            })
            .catch(function(err) {
                console.log('Falha ao registrar Service Worker:', err);
            });
    });
}
</script>

</body>
</html>