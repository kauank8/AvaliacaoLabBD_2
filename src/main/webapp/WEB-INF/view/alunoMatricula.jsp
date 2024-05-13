<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value = "./resources/matricula.css"/>'>
<title>Matricula Aluno</title>
</head>
<body>
	<nav id = menu>
	<ul>
		<li><a href="index">Home</a>
		<li><a href="aluno" > Área Aluno</a>
		<li><a href="alunoMatrciula" class="ativa" >Matricular</a>
		<li><a href="dispensaAluno">Dispensas</a>
	</ul>
	</nav>
	<div class="container_aluno">
		<h1>Matricula</h1>
		<form action="alunoMatricula" method="post" >
		<table>
				<tr>
					<td colspan="2">
						<input class="id_input_data" type="text"  id="ra" name="ra" placeholder="Ra" 
						pattern="[0-9]*" title="Por favor, digite apenas números."
						 value='<c:out value="${matricula.aluno.ra }"></c:out>'> 
					</td>
				</tr>
				<tr>
					<td>
						<input class="botao" type="submit" id="botao" name="botao" value="Listar Disciplinas Disponiveis">
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
	<c:if test="${not empty disciplinas }">
		<h1>Segunda-feira</h1>
   		<table class="table_round">
       		<thead>
            	<tr>
                	<th class="lista">Disciplina</th>
                	<th class="lista">Aulas semanais</th>
                	<th class="lista">Hora de início</th>
                	<th class="lista">Hora de fim</th>
                	<th class="lista">Confirmar Matricula</th>
            	</tr>
        	</thead>
        	<tbody>
            	<c:forEach var="d" items="${disciplinas}">
                	<c:choose>
                    	<c:when test="${d.dia_semana == 'segunda-feira'}">
                       	 	<tr>
                            	<td class="lista"><c:out value="${d.nome}" /></td>
                            	<td class="lista"><c:out value="${d.aulas_semanais}" /></td>
                            	<td class="lista" ><c:out value="${d.hora_inicio}" /></td>
                            	<td class="lista"><c:out value="${d.hora_fim}" /></td>
                            	<td>
                            	 <form class="lista" action="alunoMatricula" method="post">
                            	 	<input type="hidden" name="ra" value="${param.ra}">
                            	 	<input type="hidden" id="codigo" name="codigo" value="${d.codigo}" />
                                	<input type="hidden" id="nome" name="nome" value="${d.nome}" />
                                	<input type="hidden" id="aula_semanais" name="aulas_semanais" value="${d.aulas_semanais}" />
                                	<input type="hidden" id="hora_inicio" name="hora_inicio" value="${d.hora_inicio}" />
                                	<input type="hidden" id="hora_fim" name="hora_fim" value="${d.hora_fim}" />
                                	<input type="hidden" id="dia_semana" name="dia_semana" value="${d.dia_semana}" />
                                	<input class="botao_lista" type="submit" name="botao" value="Matricular-se">
                            	</form>
                       		 </td>
                        	</tr>
                    	</c:when>
                	</c:choose>
           	 	</c:forEach>
       		 </tbody>
   		 </table>
   		 <h1>Terça-feira</h1>
   		<table class="table_round">
       		<thead>
            	<tr>
                	<th class="lista">Disciplina</th>
                	<th class="lista">Aulas semanais</th>
                	<th class="lista">Hora de início</th>
                	<th class="lista">Hora de fim</th>
                	<th class="lista">Confirmar Matricula</th>
            	</tr>
        	</thead>
        	<tbody>
            	<c:forEach var="d" items="${disciplinas}">
                	<c:choose>
                    	<c:when test="${d.dia_semana == 'terça-feira'}">
                       	 	<tr>
                            	<td class="lista"><c:out value="${d.nome}" /></td>
                            	<td class="lista"><c:out value="${d.aulas_semanais}" /></td>
                            	<td class="lista"><c:out value="${d.hora_inicio}" /></td>
                            	<td class="lista"><c:out value="${d.hora_fim}" /></td>
                            	<td>
                            		<form class="lista" action="alunoMatricula" method="post">
                            	 	<input type="hidden" name="ra" value="${param.ra}">
                            	 	<input type="hidden" id="codigo" name="codigo" value="${d.codigo}" />
                                	<input type="hidden" id="nome" name="nome" value="${d.nome}" />
                                	<input type="hidden" id="aula_semanais" name="aulas_semanais" value="${d.aulas_semanais}" />
                                	<input type="hidden" id="hora_inicio" name="hora_inicio" value="${d.hora_inicio}" />
                                	<input type="hidden" id="hora_fim" name="hora_fim" value="${d.hora_fim}" />
                                	<input type="hidden" id="dia_semana" name="dia_semana" value="${d.dia_semana}" />
                                	<input class="botao_lista" type="submit" name="botao" value="Matricular-se">
                            	</form>
                            	</td>
                        	</tr>
                    	</c:when>
                	</c:choose>
           	 	</c:forEach>
       		 </tbody>
   		 </table>
   		 <h1>Quarta-feira</h1>
   		<table class="table_round">
       		<thead>
            	<tr>
                	<th class="lista">Disciplina</th>
                	<th class="lista">Aulas semanais</th>
                	<th class="lista">Hora de início</th>
                	<th class="lista">Hora de fim</th>
                	<th class="lista">Confirmar Matricula</th>
            	</tr>
        	</thead>
        	<tbody>
            	<c:forEach var="d" items="${disciplinas}">
                	<c:choose>
                    	<c:when test="${d.dia_semana == 'quarta-feira'}">
                       	 	<tr>
                            	<td class="lista"><c:out value="${d.nome}" /></td>
                            	<td class="lista"><c:out value="${d.aulas_semanais}" /></td>
                            	<td class="lista"><c:out value="${d.hora_inicio}" /></td>
                            	<td class="lista"><c:out value="${d.hora_fim}" /></td>
                            	<td>
                            		<form class="lista" action="alunoMatricula" method="post">
                            	 	<input type="hidden" name="ra" value="${param.ra}">
                            	 	<input type="hidden" id="codigo" name="codigo" value="${d.codigo}" />
                                	<input type="hidden" id="nome" name="nome" value="${d.nome}" />
                                	<input type="hidden" id="aula_semanais" name="aulas_semanais" value="${d.aulas_semanais}" />
                                	<input type="hidden" id="hora_inicio" name="hora_inicio" value="${d.hora_inicio}" />
                                	<input type="hidden" id="hora_fim" name="hora_fim" value="${d.hora_fim}" />
                                	<input type="hidden" id="dia_semana" name="dia_semana" value="${d.dia_semana}" />
                                	<input class="botao_lista" type="submit" name="botao" value="Matricular-se">
                            	</form>
                            	</td>
                        	</tr>
                    	</c:when>
                	</c:choose>
           	 	</c:forEach>
       		 </tbody>
   		 </table>
   		 <h1>Quinta-feira</h1>
   		<table class="table_round">
       		<thead>
            	<tr>
                	<th class="lista">Disciplina</th>
                	<th class="lista">Aulas semanais</th>
                	<th class="lista">Hora de início</th>
                	<th class="lista">Hora de fim</th>
                	<th class="lista">Confirmar Matricula</th>
            	</tr>
        	</thead>
        	<tbody>
            	<c:forEach var="d" items="${disciplinas}">
                	<c:choose>
                    	<c:when test="${d.dia_semana == 'quinta-feira'}">
                       	 	<tr>
                            	<td class="lista"><c:out value="${d.nome}" /></td>
                            	<td class="lista"><c:out value="${d.aulas_semanais}" /></td>
                            	<td class="lista"><c:out value="${d.hora_inicio}" /></td>
                            	<td class="lista"><c:out value="${d.hora_fim}" /></td>
                            	<td>
                            		<form class="lista" action="alunoMatricula" method="post">
                            	 	<input type="hidden" name="ra" value="${param.ra}">
                            	 	<input type="hidden" id="codigo" name="codigo" value="${d.codigo}" />
                                	<input type="hidden" id="nome" name="nome" value="${d.nome}" />
                                	<input type="hidden" id="aula_semanais" name="aulas_semanais" value="${d.aulas_semanais}" />
                                	<input type="hidden" id="hora_inicio" name="hora_inicio" value="${d.hora_inicio}" />
                                	<input type="hidden" id="hora_fim" name="hora_fim" value="${d.hora_fim}" />
                                	<input type="hidden" id="dia_semana" name="dia_semana" value="${d.dia_semana}" />
                                	<input class="botao_lista" type="submit" name="botao" value="Matricular-se">
                            	</form>
                            	</td>
                        	</tr>
                    	</c:when>
                	</c:choose>
           	 	</c:forEach>
       		 </tbody>
   		 </table>
   		 <h1>Sexta-feira</h1>
   		<table class="table_round">
       		<thead>
            	<tr>
                	<th class="lista">Disciplina</th>
                	<th class="lista">Aulas semanais</th>
                	<th class="lista">Hora de início</th>
                	<th class="lista">Hora de fim</th>
                	<th class="lista">Confirmar Matricula</th>
            	</tr>
        	</thead>
        	<tbody>
            	<c:forEach var="d" items="${disciplinas}">
                	<c:choose>
                    	<c:when test="${d.dia_semana == 'sexta-feira'}">
                       	 	<tr>
                            	<td class="lista"><c:out value="${d.nome}" /></td>
                            	<td class="lista"><c:out value="${d.aulas_semanais}" /></td>
                            	<td class="lista"><c:out value="${d.hora_inicio}" /></td>
                            	<td class="lista"><c:out value="${d.hora_fim}" /></td>
                            	<td>
                            		<form class="lista" action="alunoMatricula" method="post">
                            	 	<input type="hidden" name="ra" value="${param.ra}">
                            	 	<input type="hidden" id="codigo" name="codigo" value="${d.codigo}" />
                                	<input type="hidden" id="nome" name="nome" value="${d.nome}" />
                                	<input type="hidden" id="aula_semanais" name="aulas_semanais" value="${d.aulas_semanais}" />
                                	<input type="hidden" id="hora_inicio" name="hora_inicio" value="${d.hora_inicio}" />
                                	<input type="hidden" id="hora_fim" name="hora_fim" value="${d.hora_fim}" />
                                	<input type="hidden" id="dia_semana" name="dia_semana" value="${d.dia_semana}" />
                                	<input class="botao_lista" type="submit" name="botao" value="Matricular-se">
                            		</form>
                            	</td>
                        	</tr>
                    	</c:when>
                	</c:choose>
           	 	</c:forEach>
       		 </tbody>
   		 </table>
		</c:if>
	</div>	
	
	<div id="rodape">
		<p> Desenvolvido por: Kauan Paulino Farias. &copy Todos os Direitos reservados</p>
		<p>Contato para suporte: kauan.farias01@fatecsp.gov.br</p>
	</div>

</body>
</html>