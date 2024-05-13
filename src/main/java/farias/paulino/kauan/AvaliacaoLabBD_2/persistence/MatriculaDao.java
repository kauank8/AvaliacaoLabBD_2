package farias.paulino.kauan.AvaliacaoLabBD_2.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import farias.paulino.kauan.AvaliacaoLabBD_2.model.Disciplina;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Matricula;

@Repository
public class MatriculaDao implements IMatricula {
	@Autowired
	private GenericDao gDao;

	public MatriculaDao(GenericDao gDao) {
		super();
		this.gDao = gDao;
	}

	@Override
	public String inserir(Matricula m) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_insereMatricula(?, ?, ?, ?, ? ,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, m.getAluno().getRa());
		cs.setInt(2, m.getDisciplina().getCodigo());
		cs.setString(3, m.getDisciplina().getHora_inicio().toString());
		cs.setString(4, m.getDisciplina().getHora_fim().toString());
		cs.setString(5, m.getDisciplina().getDia_semana());
		cs.registerOutParameter(6, Types.VARCHAR);
		
		cs.execute();
		String saida = cs.getString(6);
		cs.close();
		c.close();
		return saida;
	}

	@Override
	public List<Disciplina> listarDisciplinas(Matricula m) throws SQLException, ClassNotFoundException {
		List<Disciplina> disciplinas = new ArrayList<>();
		Connection c = gDao.getConnection();
		
		String sql = """
				select cod_disciplina, nome, aula_semanais, dia_semana,
				hora_inicio, hora_fim
				from fn_listaDisciplina( ? )
				""";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, m.getAluno().getRa());
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			Disciplina d = new Disciplina();

			d.setCodigo(rs.getInt("cod_disciplina"));
			d.setNome(rs.getString("nome"));
			d.setAulas_semanais(rs.getInt("aula_semanais"));
			d.setDia_semana(rs.getString("dia_semana").toLowerCase());
			LocalTime hora_inicio = LocalTime.parse(rs.getString("hora_inicio"));
			d.setHora_inicio(hora_inicio);
			LocalTime hora_fim = LocalTime.parse(rs.getString("hora_fim"));
			d.setHora_fim(hora_fim);
			disciplinas.add(d);
		}
		ps.close();
		rs.close();
		c.close();

		return disciplinas;
	}

	@Override
	public List<Matricula> listarMatriculas(Matricula m) throws SQLException, ClassNotFoundException {
		List<Matricula> matriculas = new ArrayList<>();
		Connection c = gDao.getConnection();
		
		String sql = """
				Select d.nome, Lower(m.dia_semana) as dia_semana, Cast(d.hora_inicio as varchar(5)) as hora_inicio, Cast(d.hora_fim as varchar(5)) as hora_fim, m.frequencia, m.nota, m.situacao
				from Matricula m, Disciplina d
				where m.aluno_ra = (?)
				and d.codigo = m.codigo_disciplina
				order by 
				CASE m.dia_semana
				WHEN 'Segunda-feira' THEN 1
				WHEN 'Terça-feira' THEN 2
				WHEN 'Quarta-feira' THEN 3
				WHEN 'Quinta-feira' THEN 4
				WHEN 'Sexta-feira' THEN 5
				WHEN 'Sábado' THEN 6
				WHEN 'Domingo' THEN 7
				ELSE 8
				End
						""";

		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, m.getAluno().getRa());
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Matricula m1 = new Matricula();
			Disciplina d = new Disciplina();
			d.setNome(rs.getString("nome"));
			LocalTime hora_inicio = LocalTime.parse(rs.getString("hora_inicio"));
			d.setHora_inicio(hora_inicio);
			LocalTime hora_fim  = LocalTime.parse(rs.getString("hora_fim"));
			d.setHora_fim(hora_fim);
			m1.setFrequencia(rs.getInt("frequencia"));
			m1.setNota(rs.getString("nota"));
			m1.setSituacao(rs.getString("situacao"));
			d.setDia_semana(rs.getString("dia_semana"));
			m1.setDisciplina(d);
			matriculas.add(m1);
		}
		ps.close();
		rs.close();
		c.close();
		return matriculas;
	}
	
}
