<?php
include '../db/conexao.php'; // Usa o seu arquivo de conexão existente

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nome = $_POST['nome'];
    $nota = $_POST['nota'];
    $coment = $_POST['comentario'];

    // O uso de 'prepare' e 'execute' é o que garante a segurança que você quer!
    $sql = "INSERT INTO avaliacoes (nome_usuario, nota, comentario) VALUES (?, ?, ?)";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$nome, $nota, $coment]);

    echo "Avaliação enviada com sucesso!";
}
?>

