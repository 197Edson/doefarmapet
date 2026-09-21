<?php
// Define o tipo de conteúdo como HTML UTF-8 para evitar problemas com acentuação
header('Content-Type: text/html; charset=utf-8');
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Política de Privacidade - Farmacura Pet</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body { 
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; 
            line-height: 1.6; 
            background-color: #f8f9fa;
            color: #333333; 
            padding: 20px 15px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }
        h1 { 
            color: #2c3e50; 
            font-size: 26px;
            margin-bottom: 8px;
            border-bottom: 2px solid #2c3e50;
            padding-bottom: 10px;
        }
        h2 { 
            color: #34495e; 
            font-size: 18px;
            margin-top: 24px;
            margin-bottom: 10px;
        }
        p { 
            margin-bottom: 14px; 
            font-size: 15px;
        }
        .data-atualizacao {
            font-size: 13px;
            color: #7f8c8d;
            margin-bottom: 20px;
        }
        ul { 
            margin-bottom: 16px; 
            padding-left: 20px; 
        }
        li { 
            margin-bottom: 8px; 
            font-size: 15px;
        }
        .btn-voltar {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 18px;
            background-color: #2c3e50;
            color: #ffffff;
            text-decoration: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: bold;
            transition: background 0.2s ease;
        }
        .btn-voltar:hover {
            background-color: #1a252f;
        }
        footer {
            margin-top: 30px;
            text-align: center;
            font-size: 13px;
            color: #95a5a6;
            border-top: 1px solid #ecf0f1;
            padding-top: 15px;
        }
    </style>
</head>
<body>

    <div class="container">
        <a href="/" class="btn-voltar">&larr; Voltar para o App</a>

        <h1>Política de Privacidade do Farmacura Pet</h1>
        <p class="data-atualizacao"><em>Última atualização: Setembro de 2026</em></p>

        <p>A presente Política de Privacidade descreve como o aplicativo e plataforma <strong>Farmacura Pet</strong> coleta, usa, armazena e protege as informações dos usuários ao utilizar nossos serviços para a doação e mediação de medicamentos veterinários.</p>

        <h2>1. Informações Coletadas</h2>
        <p>Para o funcionamento da plataforma e comunicação entre doadores e recebedores, podemos coletar os seguintes dados:</p>
        <ul>
            <li><strong>Dados de Identificação e Contato:</strong> Nome completo, endereço de e-mail e número de telefone (quando fornecido voluntariamente no cadastro de doações ou mensagens).</li>
            <li><strong>Informações das Doações:</strong> Descrição dos medicamentos veterinários, quantidade, validade, fotos enviadas pelo usuário e localização genérica (cidade/bairro) para facilitar a retirada.</li>
            <li><strong>Dados Técnicos e de Uso:</strong> Informações do dispositivo, endereço IP e dados de navegação necessários para a segurança do sistema e manutenção das sessões.</li>
        </ul>

        <h2>2. Finalidade do Uso dos Dados</h2>
        <p>Os dados coletados são utilizados estritamente para:</p>
        <ul>
            <li>Viabilizar a conexão entre pessoas que desejam doar e pessoas que necessitam de medicamentos para animais de estimação.</li>
            <li>Facilitar o contato direto entre os envolvidos na doação.</li>
            <li>Manter a segurança, prevenção contra fraudes e estabilidade da plataforma.</li>
            <li>Atender a requisitos acadêmicos e de desenvolvimento de impacto social no projeto.</li>
        </ul>

        <h2>3. Compartilhamento de Informações</h2>
        <p>O <strong>Farmacura Pet</strong> não vende, aluga ou comercializa dados pessoais dos usuários. O compartilhamento de dados ocorre apenas:</p>
        <ul>
            <li><strong>Entre Usuários:</strong> Os dados de contato e localização de retirada cadastrados para doação serão exibidos publicamente ou para usuários interessados, a fim de possibilitar a entrega do medicamento.</li>
            <li><strong>Cumprimento Legal:</strong> Quando exigido por lei ou ordem judicial.</li>
        </ul>

        <h2>4. Armazenamento e Segurança dos Dados</h2>
        <p>Adotamos medidas técnicas de segurança adequadas para proteger os dados pessoais contra acessos não autorizados, perda ou alteração. Os dados são armazenados em servidores protegidos e o acesso é restrito aos administradores do sistema.</p>

        <h2>5. Retenção e Exclusão de Dados</h2>
        <p>Os dados pessoais permanecerão armazenados enquanto a conta do usuário ou a publicação da doação estiver ativa. O usuário pode, a qualquer momento, solicitar a exclusão de sua conta e de todos os seus dados cadastrados entrando em contato pelo e-mail de suporte.</p>

        <h2>6. Direitos do Usuário (LGPD)</h2>
        <p>Nos termos da Lei Geral de Proteção de Dados (LGPD), o usuário tem o direito de:</p>
        <ul>
            <li>Confirmar a existência do tratamento de seus dados.</li>
            <li>Acessar, corrigir ou atualizar seus dados pessoais.</li>
            <li>Solicitar a eliminação dos dados pessoais tratados com o seu consentimento.</li>
        </ul>

        <h2>7. Alterações nesta Política</h2>
        <p>Podemos atualizar esta Política de Privacidade periodicamente para refletir melhorias no sistema. Recomendamos a revisão desta página com frequência.</p>

        <h2>8. Contato</h2>
        <p>Se você tiver dúvidas, solicitações ou quiser exercer seus direitos relativos à privacidade dos seus dados, entre em contato através do e-mail de suporte:</p>
        <p><strong>E-mail:</strong> suporte.farmacurapet@gmail.com</p>

        <footer>
            &copy; <?php echo date('Y'); ?> Farmacura Pet - Todos os direitos reservados.
        </footer>
    </div>

</body>
</html>