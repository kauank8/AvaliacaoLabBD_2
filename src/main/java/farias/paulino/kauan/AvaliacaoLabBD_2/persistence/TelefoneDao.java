package farias.paulino.kauan.AvaliacaoLabBD_2.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import farias.paulino.kauan.AvaliacaoLabBD_2.model.Telefone;

@Repository
public class TelefoneDao implements ICrudTelefone {
	@Autowired
	private GenericDao gDao;

	public TelefoneDao(GenericDao gDao) {
		super();
		this.gDao = gDao;
	}

	@Override
	public String inserir(Telefone t) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_insereTelefone (?, ?, ?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, t.getAluno().getRa());
		cs.setString(2, t.getNumero());
		cs.registerOutParameter(3, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(3);
		
		cs.close();
		c.close();
		return saida;
	}

	@Override
	public String atualizar(Telefone tel_novo, Telefone tel_antigo) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_alterarTelefone (?, ?, ?, ?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, tel_novo.getAluno().getRa());
		cs.setString(2, tel_novo.getNumero());
		cs.setString(3, tel_antigo.getNumero());
		cs.registerOutParameter(4, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(4);
		
		cs.close();
		c.close();
		return saida;
	}

	@Override
	public String exclui(Telefone t) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_excluiTelefone (?, ?, ?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, t.getAluno().getRa());
		cs.setString(2, t.getNumero());
		cs.registerOutParameter(3, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(3);
		
		cs.close();
		c.close();
		return saida;
	}

	@Override
	public List<Telefone> listar(Telefone t) throws SQLException, ClassNotFoundException {
		List<Telefone> telefones = new ArrayList<>();

		Connection c = gDao.getConnection();
		String sql = "Select * From Telefone where aluno_ra = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, t.getAluno().getRa());
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Telefone tel = new Telefone();
			tel.setNumero(rs.getString("numero"));
			tel.setAluno(tel.getAluno());
			telefones.add(tel);
		}
		rs.close();
		ps.close();
		c.close();
		return telefones;
	}

}
