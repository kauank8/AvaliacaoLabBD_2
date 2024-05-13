package farias.paulino.kauan.AvaliacaoLabBD_2.persistence;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import farias.paulino.kauan.AvaliacaoLabBD_2.model.Aluno;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Disciplina;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Dispensa;

@Repository
public class DispensaDao implements IDispensa<Dispensa> {

	@Autowired
	private GenericDao gDao;

	@Override
	public String solicitarDispensa(Dispensa d) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "INSERT INTO Dispensa (motivo, data_solicitacao, status_dispensa, aluno_ra, codigo_disciplina) VALUES (?,GETDATE(),'Em Andamento',?,?)";
		PreparedStatement ps = c.prepareStatement(sql);

		ps.setString(1, d.getMotivo());
		ps.setString(2, d.getAluno().getRa());
		ps.setInt(3, d.getDisciplina().getCodigo());

		ps.execute();
		ps.close();
		c.close();

		return "Dispensa Solicitada com sucesso";
	}

	@Override
	public List<Dispensa> acompanharDispensas(Dispensa d) throws SQLException, ClassNotFoundException {
		List<Dispensa> dispensas = new ArrayList<>();

		Connection c = gDao.getConnection();

		String sql = "SELECT * FROM Dispensa where aluno_ra = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, d.getAluno().getRa());
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Dispensa d1 = new Dispensa();
			d1.setMotivo(rs.getString("motivo"));
			d1.setStatus(rs.getString("status_dispensa"));
			Date dt_solicitacao = (rs.getDate("data_solicitacao"));
			d1.setData_solicitacao(dt_solicitacao.toLocalDate());
			Disciplina disciplina = new Disciplina();
			disciplina.setCodigo(rs.getInt("codigo_disciplina"));
			d1.setDisciplina(disciplina);
			disciplina = buscarDisciplina(d1);
			d1.setDisciplina(disciplina);
			dispensas.add(d1);
		}
		rs.close();
		ps.close();
		c.close();

		return dispensas;
	}

	@Override
	public List<Disciplina> listarDisciplina(Dispensa d) throws SQLException, ClassNotFoundException {
		List<Disciplina> disciplinas = new ArrayList<>();

		Connection c = gDao.getConnection();

		String sql = """
				Select d.codigo, d.nome, d.aulas_semanais, d.hora_inicio, d.hora_fim, d.dia_semana, d.semestre
				from Disciplina d Left Outer join Dispensa dp on  d.codigo = dp.codigo_disciplina and dp.aluno_ra = ?
				where  dp.aluno_ra is null
				order by semestre asc
				""";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, d.getAluno().getRa());
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
			disciplinas.add(d1);
		}
		ps.close();
		rs.close();
		c.close();

		return disciplinas;
	}

	private Disciplina buscarDisciplina(Dispensa d) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		Disciplina d1 = new Disciplina();

		String sql = "SELECT nome FROM Disciplina where codigo = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, d.getDisciplina().getCodigo());
		ResultSet rs = ps.executeQuery();

		if (rs.next()) {
			d1.setCodigo(d.getDisciplina().getCodigo());
			d1.setNome(rs.getString("nome"));
		}
		return d1;
	}

	@Override
	public List<Dispensa> listarDispensas() throws SQLException, ClassNotFoundException {
		List<Dispensa> dispensas = new ArrayList<>();

		Connection c = gDao.getConnection();

		String sql = """
				SELECT d.aluno_ra, a.nome, d.codigo_disciplina, d.motivo, d.data_solicitacao, d.status_dispensa 
				FROM Dispensa d, Aluno a where d.aluno_ra = a.ra and d.status_dispensa = 'Em Andamento'
				order by a.nome asc
				""";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Dispensa d1 = new Dispensa();
			d1.setMotivo(rs.getString("motivo"));
			d1.setStatus(rs.getString("status_dispensa"));
			Date dt_solicitacao = (rs.getDate("data_solicitacao"));
			d1.setData_solicitacao(dt_solicitacao.toLocalDate());
			
			Disciplina disciplina = new Disciplina();
			disciplina.setCodigo(rs.getInt("codigo_disciplina"));
			d1.setDisciplina(disciplina);
			disciplina = buscarDisciplina(d1);
			d1.setDisciplina(disciplina);
			
			Aluno aluno = new Aluno();
			aluno.setNome(rs.getString("nome"));
			aluno.setRa(rs.getString("aluno_ra"));
			d1.setAluno(aluno);
			dispensas.add(d1);
		}
		rs.close();
		ps.close();
		c.close();

		return dispensas;
	}

	@Override
	public List<Dispensa> filtrarDispensas(Dispensa d) throws SQLException, ClassNotFoundException {
		List<Dispensa> dispensas = new ArrayList<>();

		Connection c = gDao.getConnection();

		String sql = """
				SELECT d.aluno_ra, a.nome, d.codigo_disciplina, d.motivo, d.data_solicitacao, d.status_dispensa 
				FROM Dispensa d, Aluno a where d.aluno_ra = a.ra and d.aluno_ra = ? and d.status_dispensa = 'Em Andamento'
				order by a.nome asc
				""";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, d.getAluno().getRa());
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Dispensa d1 = new Dispensa();
			d1.setMotivo(rs.getString("motivo"));
			d1.setStatus(rs.getString("status_dispensa"));
			Date dt_solicitacao = (rs.getDate("data_solicitacao"));
			d1.setData_solicitacao(dt_solicitacao.toLocalDate());
			
			Disciplina disciplina = new Disciplina();
			disciplina.setCodigo(rs.getInt("codigo_disciplina"));
			d1.setDisciplina(disciplina);
			disciplina = buscarDisciplina(d1);
			d1.setDisciplina(disciplina);
			
			Aluno aluno = new Aluno();
			aluno.setNome(rs.getString("nome"));
			aluno.setRa(rs.getString("aluno_ra"));
			d1.setAluno(aluno);
			dispensas.add(d1);
		}
		rs.close();
		ps.close();
		c.close();

		return dispensas;
	}

	@Override
	public String aceitar_recusar_dispensa(Dispensa d) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "Update Dispensa set status_dispensa = ? where aluno_ra = ? and codigo_disciplina = ?";
		PreparedStatement ps = c.prepareStatement(sql);

		ps.setString(1, d.getStatus());
		ps.setString(2, d.getAluno().getRa());
		ps.setInt(3, d.getDisciplina().getCodigo());
		
		ps.execute();
		ps.close();
		c.close();

		return "Dispensa respondida com sucesso";
	}

}
