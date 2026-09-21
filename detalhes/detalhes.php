<form action="salvar.php" method="POST">
    <input type="hidden" name="anuncio_id" value="<?= $id ?>">
    
    <label>Nota (1 a 5):</label>
    <input type="number" name="nota" min="1" max="5" required>
    
    <label>Comentário:</label>
    <textarea name="comentario" required></textarea>
    
    <button type="submit">Enviar Avaliação</button>
</form><br>