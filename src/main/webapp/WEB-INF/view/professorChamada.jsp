<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value = "./resources/alunoDispensa.css"/>'>
<title>Area Professor</title>
</head>
<body>
	<nav id = menu>
		<ul>
			<li><a href="index">Home</a>
			<li><a href="professorChamada" class="ativa">Area Professor</a>
		</ul>
	</nav>
	
	<div class="container_aluno">
		<h1>Aréa do professor</h1>
		<form action="professorChamada" method="post" >
			<table>
				<tr>
					<td colspan="2">
						<input class="id_input_data" type="text"  id="matricula" name="matricula" placeholder="Matricula" 
						pattern="[0-9]*" title="Por favor, digite apenas números."
						 value='<c:out value="${professor.matricula }"></c:out>'> 
					</td>
				</tr>
				<tr>
					<td>
						<input class="botao" type="submit" id="botao" name="botao" value="Listar Disciplinas">
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
		<h1>Disciplinas do professor</h1>
   		<table class="table_round">
       		<thead>
            	<tr>
            		<th class="lista">Disciplina</th>
            		<th class="lista">Dia semana</th>
                	<th class="lista">Aulas semanais</th>
                	<th class="lista">Hora de início</th>
                	<th class="lista">Hora de fim</th>
                	<th class="lista">Semestre</th>
                	<th class="lista">Curso</th>
                	<th class="lista">Acessar</th>
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
                            	<td class="lista"><c:out value="${d.curso.nome}" /></td>
                       			<td>
                       			 	<form class="lista" action="professorChamada" method="post">
                       			 		<input type="hidden" id="nome_disciplina" name="nome_disciplina" value="${d.nome}" />
                            	 		<input type="hidden" id="codigo_disciplina" name="codigo_disciplina" value="${d.codigo}" />
                            	 		<input type="hidden" id="matricula" name="matricula" value="${param.matricula}" />
                                		<input class="botao_lista" type="submit" name="botao" value="Acessar">
                            		</form>
                            	</td>
                        	</tr>
           	 	</c:forEach>
       		 </tbody>
   		 </table>
   		</c:if>
   	</div>
   	
   	<div align="center">
		<c:if test="${not empty chamadas}">
		<h1>Chamadas da disciplina: ${chamadas[0].matricula.disciplina.nome} </h1>
		<form action="professorChamada" method="post">
			<input type="hidden" id="codigo_disciplina" name="codigo_disciplina" value=" ${chamadas[0].matricula.disciplina.codigo} " />
			<input type="hidden" id="matricula" name="matricula" value="${param.matricula}" />
			<input class="botao_lista" type="submit" name="botao" value="Realizar nova chamada">
		</form>
		<br/>
		<br/>
   		<table class="table_round">
       		<thead>
            	<tr>
            		<th class="lista">Data da Chamada</th>
            		<th class="lista">Editar</th>
            	</tr>
        	</thead>
        	<tbody>
            	<c:forEach var="c" items="${chamadas}">
                       	 	<tr>
                       	 		<td class="lista"><c:out value="${c.data_aula}" /></td>
                       			<td>
                       			 	<form class="lista" action="professorChamada" method="post">
                            	 		<input type="hidden" id="data_chamada" name="data_chamada" value="${c.data_aula}" />
                            	 		<input type="hidden" id="matricula" name="matricula" value="${param.matricula}" />
                            	 		<input type="hidden" id="codigo_disciplina" name="codigo_disciplina" value="${c.matricula.disciplina.codigo}" />
                                		<input class="botao_lista" type="submit" name="botao" value="Editar">
                            		</form>
                            	</td>
                        	</tr>
           	 	</c:forEach>
       		 </tbody>
   		 </table>
   		</c:if>
   	</div>
   	
   	<div align="center">
		<c:if test="${not empty matriculas and not empty horarios}">
		<h1>Chamada turma: ${matriculas[0].ano_semestre}  </h1>
		
		<form action="professorChamada" method="post">
		<input type="hidden" id="matricula" name="matricula" value="${param.matricula}" />
		<c:if test="${matriculas[0].disciplina.aulas_semanais == 4}">
		<br/>
		<br/>
   		<table class="table_round">
       		<thead>
            	<tr>
            		<th class="lista">Ra Aluno</th>
            		<th class="lista">Aluno</th>
					<th class="lista"><c:out value="${horarios[0] } " /></th>
					<th class="lista"><c:out value="${horarios[1] } " /></th>
					<th class="lista"><c:out value="${horarios[2] } " /></th>
					<th class="lista"><c:out value="${horarios[3] } " /></th>
            	</tr>
        	</thead>
        	<tbody>
            	<c:forEach var="m" items="${matriculas}" >
            	
                       	 	<tr>
                       	 		<td class="lista"><c:out value="${m.aluno.ra}" /></td>
                       	 		<td class="lista"><c:out value="${m.aluno.nome}" /></td>
                       	 		<td class="lista"><input type="checkbox" id="check_${m.aluno.ra}_primeira_aula" name="check_${m.aluno.ra}_primeira_aula" value="1"></td>
                       	 		<td class="lista"><input type="checkbox" id="check_${m.aluno.ra}_segunda_aula" name="check_${m.aluno.ra}_segunda_aula" value="1"></td>
                       	 		<td class="lista"><input type="checkbox" id="check_${m.aluno.ra}_terceira_aula" name="check_${m.aluno.ra}_terceira_aula" value="1"></td>
                       	 		<td class="lista"><input type="checkbox" id="check_${m.aluno.ra}_quarta_aula" name="check_${m.aluno.ra}_quarta_aula" value="1"></td>
                       			<td>
                            	 		<input type="hidden" id="ra_aluno" name="ra_aluno" value="${m.aluno.ra}" />
                            	 		<input type="hidden" id="codigo_disciplina" name="codigo_disciplina" value="${m.disciplina.codigo}" />
                            	</td>
                        	</tr>
           	 	</c:forEach>
       		 </tbody>
   		 </table>
   		 </c:if>
   		 
   		 
   		 <c:if test="${matriculas[0].disciplina.aulas_semanais == 2}">
		<br/>
		<br/>
   		<table class="table_round">
       		<thead>
            	<tr>
            		<th class="lista">Ra Aluno</th>
            		<th class="lista">Aluno</th>
					<th class="lista"><c:out value="${horarios[0] } " /></th>
					<th class="lista"><c:out value="${horarios[1] } " /></th>
            	</tr>
        	</thead>
        	<tbody>
            	<c:forEach var="m" items="${matriculas}">
                       	 	<tr>
                       	 		<td class="lista"><c:out value="${m.aluno.ra}" /></td>
                       	 		<td class="lista"><c:out value="${m.aluno.nome}" /></td>
                       	 		<td class="lista"><input type="checkbox" id="check_${m.aluno.ra}_primeira_aula" name="check_${m.aluno.ra}_primeira_aula" value="1"></td>
                       			<td class="lista"><input type="checkbox" id="check_${m.aluno.ra}_segunda_aula" name="check_${m.aluno.ra}_segunda_aula" value="1"></td>
                       			<td>
                            	 		<input type="hidden" id="ra_aluno" name="ra_aluno" value="${m.aluno.ra}" />
                            	 		<input type="hidden" id="codigo_disciplina" name="codigo_disciplina" value="${m.disciplina.codigo}" />
                            	</td>
                        	</tr>
           	 	</c:forEach>
       		 </tbody>
   		 </table>
   		 </c:if>
   		 
   		 <br/>
   		 <input class="botao_lista" type="submit" name="botao" value="Confirmar chamada">
   		 
   		 </form>
   		 
   		</c:if>
   	</div>
   	
   	
   	<div align="center">
		<c:if test="${not empty editar_chamada and not empty horarios}">
		<h1>Chamada turma: ${editar_chamada[0].matricula.ano_semestre}  </h1>
		
		<form action="professorChamada" method="post">
		<input type="hidden" id="matricula" name="matricula" value="${param.matricula}" />
		<c:if test="${not empty horarios[2] }">
		<br/>
		<br/>
   		<table class="table_round">
       		<thead>
            	<tr>
            		<th class="lista">Ra Aluno</th>
            		<th class="lista">Aluno</th>
					<th class="lista"><c:out value="${horarios[0] } " /></th>
					<th class="lista"><c:out value="${horarios[1] } " /></th>
					<th class="lista"><c:out value="${horarios[2] } " /></th>
					<th class="lista"><c:out value="${horarios[3] } " /></th>
            	</tr>
        	</thead>
        	<tbody>
            	<c:forEach var="c" items="${editar_chamada}" >
            	
                       	 	<tr>
                       	 		<td class="lista"><c:out value="${c.matricula.aluno.ra}" /></td>
                       	 		<td class="lista"><c:out value="${c.matricula.aluno.nome}" /></td>
                       	 		
                       	 		<c:if test="${c.presenca_primeira_aula eq 1}">
            						<td class="lista"><input type="checkbox" id="check_${c.matricula.aluno.ra}_primeira_aula" name="check_${c.matricula.aluno.ra}_primeira_aula" value="1" checked></td>
        						</c:if>
        						<c:if test="${c.presenca_primeira_aula ne 1}">
          							<td class="lista"><input type="checkbox" id="check_${c.matricula.aluno.ra}_primeira_aula" name="check_${c.matricula.aluno.ra}_primeira_aula" value="1"></td>
       							</c:if>
       							
       							<!-- Segunda aula -->
       							<c:if test="${c.presenca_segunda_aula eq 1}">
    								<td class="lista"><input type="checkbox" id="check_${c.matricula.aluno.ra}_segunda_aula" name="check_${c.matricula.aluno.ra}_segunda_aula" value="1" checked></td>
								</c:if>
								<c:if test="${c.presenca_segunda_aula ne 1}">
    								<td class="lista"><input type="checkbox" id="check_${c.matricula.aluno.ra}_segunda_aula" name="check_${c.matricula.aluno.ra}_segunda_aula" value="1"></td>
								</c:if>
								
								<!-- Terceira aula -->
								<c:if test="${c.presenca_terceira_aula eq 1}">
								    <td class="lista"><input type="checkbox" id="check_${c.matricula.aluno.ra}_terceira_aula" name="check_${c.matricula.aluno.ra}_terceira_aula" value="1" checked></td>
								</c:if>
								<c:if test="${c.presenca_terceira_aula ne 1}">
								    <td class="lista"><input type="checkbox" id="check_${c.matricula.aluno.ra}_terceira_aula" name="check_${c.matricula.aluno.ra}_terceira_aula" value="1"></td>
								</c:if>
								
								<!-- Quarta aula -->
								<c:if test="${c.presenca_quarta_aula eq 1}">
								    <td class="lista"><input type="checkbox" id="check_${c.matricula.aluno.ra}_quarta_aula" name="check_${c.matricula.aluno.ra}_quarta_aula" value="1" checked></td>
								</c:if>
								<c:if test="${c.presenca_quarta_aula ne 1}">
								    <td class="lista"><input type="checkbox" id="check_${c.matricula.aluno.ra}_quarta_aula" name="check_${c.matricula.aluno.ra}_quarta_aula" value="1"></td>
								</c:if>
    
                       			<td>
                            	 		<input type="hidden" id="ra_aluno" name="ra_aluno" value="${c.matricula.aluno.ra}" />
                            	 		<input type="hidden" id="data_chamada" name="data_chamada" value="${c.data_aula}" />
                            	 		<input type="hidden" id="codigo_disciplina" name="codigo_disciplina" value="${c.matricula.disciplina.codigo}" />
                            	</td>
                        	</tr>
           	 	</c:forEach>
       		 </tbody>
   		 </table>
   		 </c:if>
   		 
   		 <c:if test="${empty horarios[2] }">
   		 <br/>
		<br/>
   		<table class="table_round">
       		<thead>
            	<tr>
            		<th class="lista">Ra Aluno</th>
            		<th class="lista">Aluno</th>
					<th class="lista"><c:out value="${horarios[0] } " /></th>
					<th class="lista"><c:out value="${horarios[1] } " /></th>
            	</tr>
        	</thead>
        	<tbody>
            	<c:forEach var="c" items="${editar_chamada}" >
            	
                       	 	<tr>
                       	 		<td class="lista"><c:out value="${c.matricula.aluno.ra}" /></td>
                       	 		<td class="lista"><c:out value="${c.matricula.aluno.nome}" /></td>
                       	 		
                       	 		<c:if test="${c.presenca_primeira_aula eq 1}">
            						<td class="lista"><input type="checkbox" id="check_${c.matricula.aluno.ra}_primeira_aula" name="check_${c.matricula.aluno.ra}_primeira_aula" value="1" checked></td>
        						</c:if>
        						<c:if test="${c.presenca_primeira_aula ne 1}">
          							<td class="lista"><input type="checkbox" id="check_${c.matricula.aluno.ra}_primeira_aula" name="check_${c.matricula.aluno.ra}_primeira_aula" value="1"></td>
       							</c:if>
       							
       							<!-- Segunda aula -->
       							<c:if test="${c.presenca_segunda_aula eq 1}">
    								<td class="lista"><input type="checkbox" id="check_${c.matricula.aluno.ra}_segunda_aula" name="check_${c.matricula.aluno.ra}_segunda_aula" value="1" checked></td>
								</c:if>
								<c:if test="${c.presenca_segunda_aula ne 1}">
    								<td class="lista"><input type="checkbox" id="check_${c.matricula.aluno.ra}_segunda_aula" name="check_${c.matricula.aluno.ra}_segunda_aula" value="1"></td>
								</c:if>
                       			<td>
                            	 		<input type="hidden" id="ra_aluno" name="ra_aluno" value="${c.matricula.aluno.ra}" />
                            	 		<input type="hidden" id="data_chamada" name="data_chamada" value="${c.data_aula}" />
                            	 		<input type="hidden" id="codigo_disciplina" name="codigo_disciplina" value="${c.matricula.disciplina.codigo}" />
                            	</td>
                        	</tr>
           	 	</c:forEach>
       		 </tbody>
   		 </table>
   		 </c:if>
   		 
   		 
   		 <br/>
   		 <input class="botao_lista" type="submit" name="botao" value="Editar chamada">
   		 
   		 </form>
   		 
   		</c:if>
   	</div>
   	
   	
</body>
</html>