<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value = "./resources/alunoDispensa.css"/>'>
<title>Insert title here</title>
</head>
<body>

	<nav id = menu>
	<ul>
		<li><a href="index">Home</a>
		<li><a href="secretaria" >Cadastrar Aluno</a>
		<li><a href="visualizarAluno">Visualizar/Alterar Aluno</a>
		<li><a href="telefone">Telefone</a>
		<li><a href="matricula">Matricula</a>
		<li><a href="consultarMatricula">Consulta Matricula</a>
		<li><a href="dispensaSecretaria">Dispensas</a>
		<li><a href="secretariaHistorico" class="ativa">Historico</a>
	</ul>
	</nav>
		<div class="container_aluno">
		<h1>Consultar Historico</h1>
		<form action="secretariaHistorico" method="post" >
		<table>
				<tr>
					<td colspan="2">
						<input class="id_input_data" type="text"  id="ra" name="ra" placeholder="Ra" 
						pattern="[0-9]*" title="Por favor, digite apenas números."
						 value='<c:out value="${aluno.ra }"></c:out>'> 
					</td>
				</tr>
				<tr>
					<td>
						<input class="botao" type="submit" id="botao" name="botao" value="Buscar Historico">
					</td>
				</tr>	
			</table>
		</form>
	</div>
	
	<div align="center">
		<c:if test="${not empty erro }">
			<h2><b> <c:out value="${erro }" /> </b></h2>
		</c:if>
	</div>
	
	<div align="center">
		<c:if test="${not empty saida }">
			<h3><b> <c:out value="${saida }" /> </b></h3>	
		</c:if>
	</div>
	
	<div align="center" >
	<c:if test="${not empty matriculas }">
		<h1>Historico</h1>
   		<table class="table_round">
       		<thead>
            	<tr>
                	<th class="lista">Ra Aluno</th>
                	<th class="lista">Nome Aluno </th>
                	<th class="lista">Nome Curso</th>
                	<th class="lista">Primeira Matricula</th>
                	<th class="lista">Pontuação Vestibular</th>
                	<th class="lista">Posição Vestibular</th>
            	</tr>
        	</thead>
        	<tbody>
                      <tr>
                      	<td class="lista">${matriculas[0].aluno.ra }</td>
                        <td class="lista">${matriculas[0].aluno.nome }</td>
                        <td class="lista">${matriculas[0].aluno.curso.nome }</td>
                        <td class="lista">${matriculas[0].ano_semestre }</td>
                        <td class="lista">${matriculas[0].aluno.pontuacao_vestibular }</td>
                        <td class="lista">${matriculas[0].aluno.posicao_vestibular }</td>
                      </tr>
       		 </tbody>
       		 <thead>
            	<tr>
                	<th class="lista">Codigo Disciplina</th>
                	<th class="lista">Nome Disciplina </th>
                	<th class="lista">Nome Professor</th>
                	<th class="lista">Nota Final</th>
                	<th colspan ="2" class="lista">Quantidade de Faltas</th>
            	</tr>
        	</thead>
        	<tbody>
        		<c:forEach var="m" items="${matriculas}">
                      <tr>
                      	<td class="lista"><c:out value="${m.disciplina.codigo}" /></td>
                        <td class="lista"><c:out value="${m.disciplina.nome}" /></td>
                        <td class="lista"><c:out value="${m.disciplina.professor.nome}" /></td>
                        <td class="lista"><c:out value="${m.nota}" /></td>
                        <td colspan="2" class="lista"><c:out value="${m.quantidade_faltas}" /></td>
                      </tr>
           	 	</c:forEach>
        	</tbody>
   		 </table>
	</c:if>
	</div>
	
	

</body>
</html>