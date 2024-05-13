<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value = "./resources/alunoDispensa.css"/>'>
<title>Solicitar Dispensa</title>
</head>
<body>
	<nav id = menu>
	<ul>
		<li><a href="index">Home</a>
		<li><a href="aluno" > Área Aluno</a>
		<li><a href="alunoMatricula" >Matricular</a>
		<li><a href="dispensaAluno" class="ativa" >Dispensas</a>
	</ul>
	</nav>
	
	<div class="container_aluno">
		<h1>Aréa de dispensas</h1>
		<form action="dispensaAluno" method="post" >
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
						<input class="botao" type="submit" id="botao" name="botao" value="Acompanhar Dispensas">
					</td>
					<td>
						<input class="botao" type="submit" id="botao" name="botao" value="Solicitar Dispensas">
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
		<c:if test="${not empty disciplinas }">
		<h1>Disciplinas disponiveis para dispensas</h1>
   		<table class="table_round">
       		<thead>
            	<tr>
                	<th class="lista">Disciplina</th>
                	<th class="lista">Dia da semana</th>
                	<th class="lista">Aulas semanais</th>
                	<th class="lista">Hora de início</th>
                	<th class="lista">Hora de fim</th>
                	<th class="lista">Semestre</th>
                	<th class="lista">Solicitar Dispensa</th>
            	</tr>
        	</thead>
        	<tbody>
            	<c:forEach var="d" items="${disciplinas}">
                       	 	<tr>
                            	<td class="lista"><c:out value="${d.nome}" /></td>
                            	<td class="lista"><c:out value="${d.dia_semana}" /></td>
                            	<td class="lista"><c:out value="${d.aulas_semanais}" /></td>
                            	<td class="lista" ><c:out value="${d.hora_inicio}" /></td>
                            	<td class="lista"><c:out value="${d.hora_fim}" /></td>
                            	<td class="lista"><c:out value="${d.semestre}" /></td>
                            	<td>
                            	 <form class="lista" action="dispensaAluno" method="post">
                            	 	<input type="hidden" name="ra" value="${param.ra}">
                            	 	<input type="hidden" id="codigo" name="codigo" value="${d.codigo}" />
                            	 	<input type="hidden" id="nome_disciplina" name="nome_disciplina" value="${d.nome}" />
                                	<input class="botao_lista" type="submit" name="botao" value="Selecionar para dispensa">
                            	</form>
                       		 </td>
                        	</tr>
           	 	</c:forEach>
       		 </tbody>
   		 </table>
   		</c:if>
   	</div>
   	
   	<div align="center">
		<c:if test="${not empty dispensas }">
		<h1>Dispensas Solicitadas</h1>
   		<table class="table_round">
       		<thead>
            	<tr>
                	<th class="lista">Disciplina</th>
                	<th class="lista">Motivo</th>
                	<th class="lista">Data Solicitação</th>
                	<th class="lista">Status</th>
            	</tr>
        	</thead>
        	<tbody>
            	<c:forEach var="d" items="${dispensas}">
                       	 	<tr>
                            	<td class="lista"><c:out value="${d.disciplina.nome}" /></td>
                            	<td class="lista"><c:out value="${d.motivo}" /></td>
                            	<td class="lista"><c:out value="${d.data_solicitacao}" /></td>
                            	<td class="lista" ><c:out value="${d.status}" /></td>
                        	</tr>
           	 	</c:forEach>
       		 </tbody>
   		 </table>
   		</c:if>
   	</div>
   	
   		<div align="center">
		<c:if test="${not empty disciplina }">
			<form action="dispensaAluno" method="post">
				<h1>Confirmar Dispensa</h1>
					<input type="hidden" id="ra" name="ra" value="${param.ra}">
   					<input type="hidden" id="codigo" name="codigo" value="${disciplina.codigo}" />
   					<input class="input_data" id="nome_disciplina" name="nome_disciplina" value="${disciplina.nome}" />
   					<br/>
   					<br/>
   					<textarea rows="4" cols="50"class="motivo_input_data" id="motivo" name="motivo" placeholder="Motivo"></textarea>
   					<br/>
   					<br/>
   					<input class="botao" type="submit" id="botao" name="botao" value="Confirmar">
   			</form>
   		</c:if>
   	</div>
	
	
	
	

</body>
</html>