<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value = "./resources/alunoDispensa.css"/>'>
<title>Secretaria Dispensa</title>
</head>
<body>
	<nav id = menu>
	<ul>
		<li><a href="index">Home</a>
		<li><a href="secretaria">Cadastrar Aluno</a>
		<li><a href="visualizarAluno">Visualizar/Alterar Aluno</a>
		<li><a href="telefone">Telefone</a>
		<li><a href="matricula">Matricula</a>
		<li><a href="consultarMatricula">Consulta Matricula</a>
		<li><a href="dispensaSecretaria" class="ativa">Dispensas</a>
		<li><a href="secretariaHistorico">Historico</a>
	</ul>
	</nav>

	<div class="container_aluno">
		<h1>Aréa de dispensas</h1>
		<form action="dispensaSecretaria" method="post" >
			<table>
				<tr>
					<td colspan="2">
						<input class="id_input_data" type="text"  id="ra" name="ra" placeholder="Ra" 
						pattern="[0-9]*" title="Por favor, digite apenas números."
						 value='<c:out value="${dispensa.aluno.ra }"></c:out>'> 
					</td>
				</tr>
				<tr>
					<td>
						<input class="botao" type="submit" id="botao" name="botao" value="Filtar por Ra">
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
	
	<div align="center">
		<c:if test="${not empty dispensas }">
		<h1>Dispensas Solicitadas</h1>
   		<table class="table_round">
       		<thead>
            	<tr>
            		<th class="lista">Aluno Ra</th>
            		<th class="lista">Nome Aluno</th>
                	<th class="lista">Disciplina</th>
                	<th class="lista">Motivo</th>
                	<th class="lista">Data Solicitação</th>
                	<th class="lista">Status</th>
                	<th class="lista">Aceitar</th>
                	<th class="lista">Recusar</th>
            	</tr>
        	</thead>
        	<tbody>
            	<c:forEach var="d" items="${dispensas}">
                       	 	<tr>
                       	 		<td class="lista"><c:out value="${d.aluno.ra}" /></td>
                       	 		<td class="lista"><c:out value="${d.aluno.nome}" /></td>
                            	<td class="lista"><c:out value="${d.disciplina.nome}" /></td>
                            	<td class="lista"><c:out value="${d.motivo}" /></td>
                            	<td class="lista"><c:out value="${d.data_solicitacao}" /></td>
                            	<td class="lista" ><c:out value="${d.status}" /></td>
                       			<td>
                       			 	<form class="lista" action="dispensaSecretaria" method="post">
                            	 	<input type="hidden" name="ra" value="${d.aluno.ra}">
                            	 	<input type="hidden" id="codigo" name="codigo" value="${d.disciplina.codigo}" />
                                	<input class="botao_lista" type="submit" name="botao" value="Aceitar">
                            		</form>
                            	</td>
                            	<td>
                            		<form class="lista" action="dispensaSecretaria" method="post">
                            	 	<input type="hidden" name="ra" value="${d.aluno.ra}">
                            	 	<input type="hidden" id="codigo" name="codigo" value="${d.disciplina.codigo}" />
                                	<input class="botao_lista" type="submit" name="botao" value="Recusar">
                            		</form>
                            	</td>
                        	</tr>
           	 	</c:forEach>
       		 </tbody>
   		 </table>
   		</c:if>
   	</div>
</body>
</html>