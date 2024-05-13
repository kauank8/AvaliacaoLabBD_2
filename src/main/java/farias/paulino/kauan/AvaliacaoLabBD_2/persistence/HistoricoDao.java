package farias.paulino.kauan.AvaliacaoLabBD_2.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import farias.paulino.kauan.AvaliacaoLabBD_2.model.Aluno;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Curso;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Disciplina;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Matricula;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Professor;

@Repository
public class HistoricoDao implements IHistorico {

	@Autowired
	private GenericDao gDao;
	
	@Override
	public List<Matricula> buscar_historico(Aluno a) throws SQLException, ClassNotFoundException {
		List<Matricula> matriculas = new ArrayList<>();
		Connection c = gDao.getConnection();
		String sql = """
				Select * from fn_historico(?)
				""";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, a.getRa());
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			Matricula m = new Matricula();
			Curso curso = new Curso();
			Disciplina d = new Disciplina();
			Professor p = new Professor();
			
			a.setNome(rs.getString("nome_aluno"));
			a.setRa(rs.getString("ra_aluno"));
			curso.setNome(rs.getString("nome_curso"));
			a.setCurso(curso);
			a.setPontuacao_vestibular(rs.getDouble("pontuacao_vestibular"));
			a.setPosicao_vestibular(rs.getInt("posicao_vestibular"));
			
			d.setCodigo(rs.getInt("codigo_disciplina"));
			d.setNome(rs.getString("nome_disciplina"));
			p.setNome(rs.getString("nome_professor"));
			d.setProfessor(p);
			
			
			m.setAluno(a);
			m.setAno_semestre(rs.getInt("primeira_matricula"));
			m.setDisciplina(d);
			m.setNota(rs.getString("nota_final"));
			m.setQuantidade_faltas(rs.getInt("quantidade_faltas"));
			matriculas.add(m);

		}
		return matriculas;
	}
}
