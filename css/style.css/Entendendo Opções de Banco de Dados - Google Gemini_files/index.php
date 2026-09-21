<?php
header('Content-Type: text/html; charset=utf-8');
require_once "conexao.php";

$busca = isset($_GET['q']) ? $_GET['q'] : '';
$sql = "SELECT * FROM anuncios WHERE status = 'ativo'";

if ($busca != '') {
    $sql .= " AND (titulo LIKE ? OR descricao LIKE ? OR categoria LIKE ?)";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(["%$busca%", "%$busca%", "%$busca%"]);
} else {
    $stmt = $pdo->query($sql);
}
$anuncios = $stmt->fetchAll();
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DoeFarmaPet - Recife</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root { --primary: #2D6A4F; --bg: #F8FAF9; --text: #333; }
        body { font-family: 'Segoe UI', sans-serif; background-color: var(--bg); margin: 0; color: var(--text); }
        
        /* Header */
        header { 
            background: #fff; padding: 15px 5%; display: flex; 
            justify-content: space-between; align-items: center; 
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .logo { display: flex; align-items: center; gap: 10px; font-weight: 800; font-size: 20px; color: var(--primary); text-decoration: none; }
        .logo img { height: 50px; width: auto; object-fit: contain; }

        /* Menu */
        .menu-topo { display: flex; gap: 15px; align-items: center; }
        .menu-topo a { 
            text-decoration: none; color: var(--text); font-weight: 600; 
            display: flex; align-items: center; gap: 8px; transition: 0.3s;
            padding: 8px 12px; border-radius: 8px; font-size: 14px;
        }
        .menu-topo a:hover { background: #e8f5e9; color: var(--primary); }
        .btn-conta { background: var(--primary); color: #fff !important; padding: 8px 15px !important; border-radius: 20px !important; }
        .btn-conta:hover { background: #1b4332 !important; }

        /* Busca */
        .busca-container { display: flex; gap: 5px; width: 350px; }
        .busca-container input { padding: 8px 15px; border: 1px solid #ddd; border-radius: 20px; flex: 1; outline: none; }
        .busca-container button { padding: 8px 20px; background: var(--primary); color: white; border: none; border-radius: 20px; cursor: pointer; }

        /* Conteúdo */
        .missao { background: #E8F5E9; padding: 40px 5%; text-align: center; }
        
        /* Grid */
        .grid-anuncios { display: flex; gap: 20px; padding: 40px 5%; overflow-x: auto; }
        .card { background: white; border: 1px solid #eee; padding: 15px; border-radius: 10px; min-width: 220px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .img-produto { width: 100%; height: 150px; object-fit: cover; border-radius: 8px; margin-bottom: 10px; }
        .btn-interesse { display: block; background: var(--primary); color: white; padding: 10px; border-radius: 5px; text-decoration: none; margin-top: 10px; font-weight: bold; }

        /* Botão Flutuante WhatsApp */
        .btn-whatsapp {
            position: fixed; bottom: 20px; right: 20px; background-color: #25D366; color: white;
            padding: 12px 20px; border-radius: 50px; text-decoration: none; font-weight: bold;
            display: flex; align-items: center; gap: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.2);
            z-index: 1000; transition: 0.3s;
        }
        .btn-whatsapp:hover { background-color: #128C7E; transform: scale(1.05); }

        /* Responsividade (Ajustes Clarice) */
        @media (max-width: 768px) {
            header { flex-direction: column; gap: 15px; text-align: center; }
            .busca-container { width: 100%; max-width: 300px; }
            .menu-topo { gap: 10px; flex-wrap: wrap; justify-content: center; }
        }
    </style>
</head>
<body>

<header>
    <a href="index.php" class="logo">
        <img src="https://static.vecteezy.com/ti/vetor-gratis/p1/17352349-ilustracao-do-logotipo-de-uma-clinica-veterinaria-vetor.jpg" alt="Logo">
        <span>DOEFARMAPET</span>
    </a>

    <form action="index.php" method="GET" class="busca-container">
        <input type="text" name="q" placeholder="Buscar remédio ou acessório..." value="<?= htmlspecialchars($busca) ?>">
        <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
    </form>

    <nav class="menu-topo">
        <a href="saude.php"><i class="fa-solid fa-stethoscope"></i> Clínicas</a>
        <a href="parceiros.php"><i class="fa-solid fa-hand-holding-heart"></i> ONGs</a>
        <a href="login.php" class="btn-conta"><i class="fa-solid fa-user"></i> Conta</a>
    </nav>
</header>

<section class="missao">
    <h1>Nossa Missão</h1>
    <p>Nossa missão é que nenhum medicamento pet se perca na gaveta. Ajude outro animal a se tratar: doe o remédio que sobrou ou acessórios que já não usa mais. Outros animais estão aguardando este gesto de solidariedade!</p>
</section>

<section class="shopee-container" style="padding: 30px 5%; text-align: center;">
    <a href="https://shopee.com.br/search?keyword=pets" target="_blank" style="text-decoration: none; display: block; background: #fff; padding: 20px; border-radius: 15px; border: 2px solid #ee4d2d; max-width: 400px; margin: 0 auto; box-shadow: 0 4px 10px rgba(0,0,0,0.1);">
        <img src="https://logodownload.org/wp-content/uploads/2021/04/shopee-logo-1.png" alt="Shopee" style="width: 150px; display: block; margin: 0 auto 10px auto;">
        <p style="color: #333; font-weight: bold; margin: 0;">Ofertas Pet na Shopee</p>
        <span style="color: #ee4d2d; font-size: 12px;">Clique aqui e confira!</span>
    </a>
</section>

<section><br><br>
    <h2 style="padding: 20px 5%;">Doações Recentes</h2><a href="">
    
    <?php if (empty($anuncios)): ?>
        <div style="padding: 40px; text-align: center; color: #666;">
            <i class="fa-solid fa-search" style="font-size: 30px; margin-bottom: 10px;"></i>
            <p>Nenhuma doação encontrada para sua busca. Tente outros termos!</p>
            <a href="index.php" style="color: var(--primary); font-weight: bold;">Ver todas as doações</a>
        </div>
    <?php else: ?>
        <div class="grid-anuncios">
            <?php foreach ($anuncios as $a): ?>
                <div class="card">
                    <img src="uploads/<?= htmlspecialchars($a['foto']) ?>" 
                         alt="<?= htmlspecialchars($a['titulo']) ?>" 
                         class="img-produto"
                         onerror="this.src='https://via.placeholder.com/200?text=Sem+Foto'">
                    <h3><?= htmlspecialchars($a['titulo']) ?></h3>
                    <a href="detalhes.php?id=<?= $a['id'] ?>" class="btn-interesse">TENHO INTERESSE</a>
                </div>
            <?php endforeach; ?>
        </div>
    <?php endif; ?>
</section>

<a href="https://wa.me/5581993057487?text=Olá, gostaria de enviar um feedback sobre o DoeFarmaPet." 
   target="_blank" 
   class="btn-whatsapp">
   <i class="fa-brands fa-whatsapp"></i> Sugestões/Elogios
</a>

</body>
</html>