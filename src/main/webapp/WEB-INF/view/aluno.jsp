<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value = "./resources/consultarMatricula.css"/>'>
<title>Area do Aluno</title>
</head>
<body>
	<nav id = menu>
	<ul>
		<li><a href="index">Home</a>
		<li><a href="aluno" class="ativa"> Área Aluno</a>
		<li><a href="alunoMatricula" >Matricular</a>
		<li><a href="dispensaAluno" >Dispensas</a>
	</ul>
	</nav>
	<div class="container_aluno">
		<h1>Matriculas Ativas</h1>
		<form action="aluno" method="post" >
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
						<input class="botao" type="submit" id="botao" name="botao" value="Listar Matriculas Ativas">
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
		<h1>Lista de materias</h1>
   		<table class="table_round">
       		<thead>
            	<tr>
                	<th class="lista">Disciplina</th>
                	<th class="lista">Dia da semana </th>
                	<th class="lista">Hora de início</th>
                	<th class="lista">Hora de fim</th>
                	<th class="lista">Nota</th>
                	<th class="lista">Frequência</th>
                	<th class="lista">Situação</th>
            	</tr>
        	</thead>
        	<tbody>
            	<c:forEach var="m" items="${matriculas}">
                      <tr>
                      	<td class="lista"><c:out value="${m.disciplina.nome}" /></td>
                        <td class="lista"><c:out value="${m.disciplina.dia_semana}" /></td>
                        <td class="lista"><c:out value="${m.disciplina.hora_inicio}" /></td>
                        <td class="lista"><c:out value="${m.disciplina.hora_fim}" /></td>
                        <td class="lista"><c:out value="${m.nota}" /></td>
                        <td class="lista"><c:out value="${m.frequencia}" /></td>
                        <td class="lista"><c:out value="${m.situacao}" /></td>
                      </tr>
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