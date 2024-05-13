package farias.paulino.kauan.AvaliacaoLabBD_2.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import farias.paulino.kauan.AvaliacaoLabBD_2.model.Aluno;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Chamada;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Curso;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Disciplina;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Matricula;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Professor;

@Repository
public class ProfessorDao implements IProfessorDao {
	@Autowired
	private GenericDao gDao;

	@Override
	public List<Disciplina> listar_disciplinas(Professor p) throws SQLException, ClassNotFoundException {
		List<Disciplina> disciplinas = new ArrayList<>();

		Connection c = gDao.getConnection();
		String sql = """
				Select d.codigo, d.nome, d.aulas_semanais, d.hora_inicio, d.hora_fim, d.dia_semana, d.semestre, c.nome as nome_curso
				from Disciplina d, Curso c where d.codigo_curso = c.codigo and d.matricula_professor =  ?
				""";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, p.getMatricula());
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Disciplina d1 = new Disciplina();

			d1.setCodigo(rs.getInt("codigo"));
			d1.setNome(rs.getString("nome"));
			d1.setAulas_semanais(rs.getInt("aulas_semanais"));
			d1.setDia_semana(rs.getString("dia_semana").toLowerCase());
			LocalTime hora_inicio = LocalTime.parse(rs.getString("hora_inicio"));
			d1.setHora_inicio(hora_inicio);
			LocalTime hora_fim = LocalTime.parse(rs.getString("hora_fim"));
			d1.setHora_fim(hora_fim);
			d1.setSemestre(rs.getInt("semestre"));

			Curso curso = new Curso();
			curso.setNome(rs.getString("nome_curso"));
			d1.setCurso(curso);

			disciplinas.add(d1);
		}
		ps.close();
		rs.close();
		c.close();

		return disciplinas;

	}

	@Override
	public List<Chamada> listar_chamada(Disciplina d) throws SQLException, ClassNotFoundException {
		List<Chamada> chamadas = new ArrayList<>();

		Connection c = gDao.getConnection();
		String sql = """
				Select Distinct data_aula from Chamada where codigo_disciplina = ?
				""";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, d.getCodigo());
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Chamada chamada = new Chamada();

			Matricula m = new Matricula();
			m.setDisciplina(d);

			Date data = rs.getDate("data_aula");
			chamada.setData_aula(data.toLocalDate());
			chamada.setMatricula(m);

			chamadas.add(chamada);
		}

		ps.close();
		rs.close();
		c.close();

		return chamadas;
	}

	@Override
	public Object[] listar_alunosChamada(Disciplina d) throws SQLException, ClassNotFoundException {
		Object[] saidas = new Object[2];
		List<Matricula> matriculas = new ArrayList<>();
		StringBuffer buffer = new StringBuffer();
		Connection c = gDao.getConnection();
		String sql = """
				Select * from fn_alunosChamada(?)
				""";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, d.getCodigo());
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Matricula m = new Matricula();
			Aluno a = new Aluno();
			a.setNome(rs.getString("nome_aluno"));
			a.setRa(rs.getString("ra_aluno"));

			d.setAulas_semanais(rs.getInt("aulas_semanais"));
			d.setCodigo(d.getCodigo());

			m.setAluno(a);
			m.setAno_semestre(rs.getInt("turma"));
			m.setDisciplina(d);
			matriculas.add(m);

		}
		rs = ps.executeQuery();
		if (rs.next()) {
			if (d.getAulas_semanais() == 2 || d.getAulas_semanais() == 4) {
				buffer.append(rs.getString("primeira_aula") + "/n");
				buffer.append(rs.getString("segunda_aula") + "/n");
			}
			if (d.getAulas_semanais() == 4) {
				buffer.append(rs.getString("terceira_aula") + "/n");
				buffer.append(rs.getString("quarta_aula") + "/n");
			}
		}
		ps.close();
		rs.close();
		c.close();

		saidas[0] = matriculas;
		saidas[1] = buffer.toString();

		return saidas;
	}

	@Override
	public String inserir_chamada(Chamada cm) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_insereChamada(?, ?, ?, ?, ? ,?, ?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, cm.getMatricula().getAluno().getRa());
		cs.setInt(2, cm.getMatricula().getDisciplina().getCodigo() );
		cs.setInt(3, cm.getPresenca_primeira_aula());
		cs.setInt(4, cm.getPresenca_segunda_aula());
		cs.setInt(5, cm.getPresenca_terceira_aula());
		cs.setInt(6, cm.getPresenca_quarta_aula());
		cs.registerOutParameter(7, Types.VARCHAR);
		
		cs.execute();
		String saida = cs.getString(7);
		cs.close();
		c.close();
		return saida;
		
	}

	@Override
	public List<Chamada> lista_editar_chamada(Chamada cm) throws SQLException, ClassNotFoundException {
		List<Chamada> chamadas = new ArrayList<>();
		Connection c = gDao.getConnection();
		String sql = """
				Select c.presenca_primeira_aula, c.presenca_segunda_aula, c.presenca_terceira_aula, c.presenca_quarta_aula,
				c.data_aula, c.codigo_disciplina, c.aluno_ra, a.nome, c.semestre
				from Chamada c, Aluno a where codigo_disciplina = ? and data_aula = ?
				and c.aluno_ra = a.ra
				""";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, cm.getMatricula().getDisciplina().getCodigo());
		ps.setString(2, cm.getData_aula().toString());
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			Matricula m = new Matricula();
			
			Chamada c1 = new Chamada();
			Aluno a = new Aluno();
			a.setRa(rs.getString("aluno_ra"));
			a.setNome(rs.getString("nome"));
			
			Disciplina d = new Disciplina();
			d.setCodigo(rs.getInt("codigo_disciplina"));
			

			m.setAluno(a);
			m.setAno_semestre(rs.getInt("semestre"));
			m.setDisciplina(d);
			
			c1.setPresenca_primeira_aula(rs.getInt("presenca_primeira_aula"));
			c1.setPresenca_segunda_aula(rs.getInt("presenca_segunda_aula"));
			c1.setPresenca_terceira_aula(rs.getInt("presenca_terceira_aula"));
			c1.setPresenca_quarta_aula(rs.getInt("presenca_quarta_aula"));
			c1.setMatricula(m);
			c1.setData_aula(cm.getData_aula());
			
			chamadas.add(c1);
		}
		
		ps.close();
		rs.close();
		c.close();
		return chamadas;
	}

	@Override
	public String atualizar_chamada(Chamada cm) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_atualizaChamada(?, ?, ?, ?, ? ,?, ?, ?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, cm.getMatricula().getAluno().getRa());
		cs.setInt(2, cm.getMatricula().getDisciplina().getCodigo() );
		cs.setInt(3, cm.getPresenca_primeira_aula());
		cs.setInt(4, cm.getPresenca_segunda_aula());
		cs.setInt(5, cm.getPresenca_terceira_aula());
		cs.setInt(6, cm.getPresenca_quarta_aula());
		cs.setString(7, cm.getData_aula().toString());
		cs.registerOutParameter(8, Types.VARCHAR);
		
		cs.execute();
		String saida = cs.getString(8);
		cs.close();
		c.close();
		return saida;
	}

}
