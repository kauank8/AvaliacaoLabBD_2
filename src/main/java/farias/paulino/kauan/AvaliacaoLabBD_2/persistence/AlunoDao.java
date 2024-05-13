package farias.paulino.kauan.AvaliacaoLabBD_2.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import farias.paulino.kauan.AvaliacaoLabBD_2.model.Aluno;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Curso;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Telefone;

@Repository
public class AlunoDao implements ICrudAluno<Aluno> {
	
	@Autowired
	private GenericDao gDao;
	
	
	@Override
	public String inserir(Aluno a) throws SQLException, ClassNotFoundException {
		String saida = insupdt(a, "I");
		return saida;
	}

	@Override
	public String atualizar(Aluno a) throws SQLException, ClassNotFoundException {
		String saida = insupdt(a, "U");
		return saida;
	}

	@Override
	public Aluno consultar(Aluno a) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		
		String sql = "Select * from Aluno where ra = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, a.getRa());
		ResultSet rs = ps.executeQuery();

		if (rs.next()) {
			a.setRa(rs.getString("ra"));
			a.setCpf(rs.getString("cpf"));
			a.setNome(rs.getString("nome"));
			a.setNome_social(rs.getString("nome_social"));
			Date dt_nasc = rs.getDate("data_nascimento");
			a.setData_nasc(dt_nasc.toLocalDate());
			a.setEmail_corporativo(rs.getString("email_corporativo"));
			a.setEmail_pessoal(rs.getString("email_pessoal"));
			Date dt_conclusao = rs.getDate("conclusao_segundoGrau");
			a.setConclusao_segundo_grau(dt_conclusao.toLocalDate());
			a.setInstituicao_segundo_grau(rs.getString("instituicao_segundoGrau"));
			a.setPontuacao_vestibular(rs.getDouble("pontuacao_vestibular"));
			a.setPosicao_vestibular(rs.getInt("posicao_vestibular"));
			Curso curso = new Curso();
			curso.setCodigo(rs.getInt("curso_codigo"));
			a.setCurso(curso);
		}
		rs.close();
		ps.close();
		c.close();
		return a;
	}

	@Override
	public List<Aluno> listar() throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		List<Aluno> alunos = new ArrayList<>();
		String sql = "Select * from Aluno ";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Aluno a = new Aluno();
			List<Telefone> telefones = new ArrayList<>();
			a.setRa(rs.getString("ra"));
			a.setCpf(rs.getString("cpf"));
			a.setNome(rs.getString("nome"));
			a.setNome_social(rs.getString("nome_social"));
			Date dt_nasc = rs.getDate("data_nascimento");
			a.setData_nasc(dt_nasc.toLocalDate());
			a.setEmail_corporativo(rs.getString("email_corporativo"));
			a.setEmail_pessoal(rs.getString("email_pessoal"));
			Date dt_conclusao = rs.getDate("conclusao_segundoGrau");
			a.setConclusao_segundo_grau(dt_conclusao.toLocalDate());
			a.setInstituicao_segundo_grau(rs.getString("instituicao_segundoGrau"));
			a.setPontuacao_vestibular(rs.getDouble("pontuacao_vestibular"));
			a.setPosicao_vestibular(rs.getInt("posicao_vestibular"));
			a.setAno_ingresso(rs.getInt("ano_ingresso"));
			a.setSemestre_ingresso(rs.getInt("semestre_ingresso"));
			a.setAno_limite(rs.getInt("ano_limite"));
			a.setSemestre_limite(rs.getInt("semestre_limite"));
			Curso curso = new Curso();
			curso.setCodigo(rs.getInt("curso_codigo"));
			a.setCurso(curso);

			alunos.add(a);
		}
		rs.close();
		ps.close();
		c.close();
		return alunos;
	}

	private String insupdt(Aluno a, String op) throws ClassNotFoundException, SQLException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_aluno(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		if (a.getNome_social().isBlank()) {
			a.setNome_social(null);
		}
		cs.setString(1, op);
		cs.setInt(2, a.getCurso().getCodigo());
		cs.setString(3, a.getRa());
		cs.setString(4, a.getCpf());
		cs.setString(5, a.getNome());
		cs.setString(6, a.getNome_social());
		cs.setString(7, a.getData_nasc().toString());
		cs.setString(8, a.getConclusao_segundo_grau().toString());
		cs.setString(9, a.getEmail_pessoal());
		cs.setString(10, a.getEmail_corporativo());
		cs.setString(11, a.getInstituicao_segundo_grau());
		cs.setDouble(12, a.getPontuacao_vestibular());
		cs.setInt(13, a.getPosicao_vestibular());
		cs.registerOutParameter(14, Types.VARCHAR);
		cs.execute();

		String saida = cs.getString(14);
		cs.close();
		c.close();
		return saida;

	}

	@Override
	public String GeraRa() throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_geraRa (?)}";
		CallableStatement cs = c.prepareCall(sql);

		cs.registerOutParameter(1, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(1);
		cs.close();
		c.close();
		return saida;

	}
}
